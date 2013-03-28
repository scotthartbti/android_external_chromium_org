// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "chrome/browser/chromeos/policy/user_cloud_policy_manager_chromeos.h"

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "chrome/browser/policy/cloud/cloud_policy_refresh_scheduler.h"
#include "chrome/browser/policy/cloud/cloud_policy_service.h"
#include "chrome/browser/policy/cloud/resource_cache.h"
#include "chrome/browser/policy/policy_bundle.h"
#include "chrome/common/pref_names.h"
#include "net/url_request/url_request_context_getter.h"

namespace em = enterprise_management;

namespace policy {

UserCloudPolicyManagerChromeOS::UserCloudPolicyManagerChromeOS(
    scoped_ptr<CloudPolicyStore> store,
    scoped_ptr<ResourceCache> resource_cache,
    bool wait_for_policy_fetch)
    : CloudPolicyManager(
          PolicyNamespaceKey(dm_protocol::kChromeUserPolicyType, std::string()),
          store.get()),
      store_(store.Pass()),
      wait_for_policy_fetch_(wait_for_policy_fetch) {
  if (resource_cache) {
    component_policy_service_.reset(new ComponentCloudPolicyService(
        this, store_.get(), resource_cache.Pass()));
  }
}

UserCloudPolicyManagerChromeOS::~UserCloudPolicyManagerChromeOS() {}

void UserCloudPolicyManagerChromeOS::Connect(
    PrefService* local_state,
    DeviceManagementService* device_management_service,
    scoped_refptr<net::URLRequestContextGetter> request_context,
    UserAffiliation user_affiliation) {
  DCHECK(device_management_service);
  DCHECK(local_state);
  local_state_ = local_state;
  scoped_ptr<CloudPolicyClient> cloud_policy_client(
      new CloudPolicyClient(std::string(), std::string(), user_affiliation,
                            NULL, device_management_service));
  core()->Connect(cloud_policy_client.Pass());
  client()->AddObserver(this);

  if (component_policy_service_)
    component_policy_service_->Connect(client(), request_context);

  if (wait_for_policy_fetch_) {
    // If we are supposed to wait for a policy fetch, we trigger an explicit
    // policy refresh at startup that allows us to unblock initialization once
    // done. The refresh scheduler only gets started once that refresh
    // completes. Note that we might have to wait for registration to happen,
    // see OnRegistrationStateChanged() below.
    if (client()->is_registered()) {
      service()->RefreshPolicy(
          base::Bind(
              &UserCloudPolicyManagerChromeOS::OnInitialPolicyFetchComplete,
              base::Unretained(this)));
    }
  } else {
    CancelWaitForPolicyFetch();
  }
}

void UserCloudPolicyManagerChromeOS::CancelWaitForPolicyFetch() {
  wait_for_policy_fetch_ = false;
  CheckAndPublishPolicy();

  // Now that |wait_for_policy_fetch_| is guaranteed to be false, the scheduler
  // can be started.
  StartRefreshScheduler();
}

bool UserCloudPolicyManagerChromeOS::IsClientRegistered() const {
  return client() && client()->is_registered();
}

void UserCloudPolicyManagerChromeOS::RegisterClient(
    const std::string& access_token) {
  DCHECK(client()) << "Callers must invoke Initialize() first";
  if (!client()->is_registered()) {
    DVLOG(1) << "Registering client with access token: " << access_token;
    client()->Register(em::DeviceRegisterRequest::USER,
                       access_token, std::string(), false);
  }
}

void UserCloudPolicyManagerChromeOS::Shutdown() {
  if (client())
    client()->RemoveObserver(this);
  component_policy_service_.reset();
  CloudPolicyManager::Shutdown();
}

bool UserCloudPolicyManagerChromeOS::IsInitializationComplete(
    PolicyDomain domain) const {
  if (!CloudPolicyManager::IsInitializationComplete(domain))
    return false;
  if (domain == POLICY_DOMAIN_CHROME)
    return !wait_for_policy_fetch_;
  if (ComponentCloudPolicyService::SupportsDomain(domain) &&
      component_policy_service_) {
    return component_policy_service_->is_initialized();
  }
  return true;
}

void UserCloudPolicyManagerChromeOS::RegisterPolicyDomain(
    PolicyDomain domain,
    const std::set<std::string>& component_ids) {
  if (ComponentCloudPolicyService::SupportsDomain(domain) &&
      component_policy_service_) {
    component_policy_service_->RegisterPolicyDomain(domain, component_ids);
  }
}

scoped_ptr<PolicyBundle> UserCloudPolicyManagerChromeOS::CreatePolicyBundle() {
  scoped_ptr<PolicyBundle> bundle = CloudPolicyManager::CreatePolicyBundle();
  if (component_policy_service_)
    bundle->MergeFrom(component_policy_service_->policy());
  return bundle.Pass();
}

void UserCloudPolicyManagerChromeOS::OnPolicyFetched(
    CloudPolicyClient* client) {
  // No action required. If we're blocked on a policy fetch, we'll learn about
  // completion of it through OnInitialPolicyFetchComplete().
}

void UserCloudPolicyManagerChromeOS::OnRegistrationStateChanged(
    CloudPolicyClient* cloud_policy_client) {
  DCHECK_EQ(client(), cloud_policy_client);
  if (wait_for_policy_fetch_) {
    // If we're blocked on the policy fetch, now is a good time to issue it.
    if (client()->is_registered()) {
      service()->RefreshPolicy(
          base::Bind(
              &UserCloudPolicyManagerChromeOS::OnInitialPolicyFetchComplete,
              base::Unretained(this)));
    } else {
      // If the client has switched to not registered, we bail out as this
      // indicates the cloud policy setup flow has been aborted.
      CancelWaitForPolicyFetch();
    }
  }
}

void UserCloudPolicyManagerChromeOS::OnClientError(
    CloudPolicyClient* cloud_policy_client) {
  DCHECK_EQ(client(), cloud_policy_client);
  CancelWaitForPolicyFetch();
}

void UserCloudPolicyManagerChromeOS::OnComponentCloudPolicyRefreshNeeded() {
  core()->RefreshSoon();
}

void UserCloudPolicyManagerChromeOS::OnComponentCloudPolicyUpdated() {
  CheckAndPublishPolicy();
  StartRefreshScheduler();
}

void UserCloudPolicyManagerChromeOS::OnInitialPolicyFetchComplete(
    bool success) {
  CancelWaitForPolicyFetch();
}

void UserCloudPolicyManagerChromeOS::StartRefreshScheduler() {
  if (core()->refresh_scheduler())
    return;  // Already started.

  if (wait_for_policy_fetch_)
    return;  // Still waiting for the initial, blocking fetch.

  if (!service() || !local_state_)
    return;  // Not connected.

  if (component_policy_service_ &&
      !component_policy_service_->is_initialized()) {
    // If the client doesn't have the list of components to fetch yet then don't
    // start the scheduler. The |component_policy_service_| will call back into
    // OnComponentCloudPolicyUpdated() once it's ready.
    return;
  }

  core()->StartRefreshScheduler();
  core()->TrackRefreshDelayPref(local_state_, prefs::kUserPolicyRefreshRate);
}

}  // namespace policy

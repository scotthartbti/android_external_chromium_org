// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_PUBLIC_UTILITY_RUN_LOOP_H_
#define MOJO_PUBLIC_UTILITY_RUN_LOOP_H_

#include <map>

#include "mojo/public/system/core_cpp.h"

namespace mojo {
namespace utility {

class RunLoopHandler;

class RunLoop {
 public:
  RunLoop();
  ~RunLoop();

  // Sets up state needed for RunLoop. This must be invoked before creating a
  // RunLoop.
  static void SetUp();

  // Cleans state created by Setup().
  static void TearDown();

  // Returns the RunLoop for the current thread. Returns NULL if not yet
  // created.
  static RunLoop* current();

  // Registers a RunLoopHandler for the specified handle. Only one handler can
  // be registered for a specified handle.
  void AddHandler(RunLoopHandler* handler,
                  const Handle& handle,
                  MojoWaitFlags wait_flags,
                  MojoDeadline deadline);
  void RemoveHandler(const Handle& handle);

  // Runs the loop servicing handles as they are ready. This returns when Quit()
  // is invoked, or there no more handles.
  void Run();
  void Quit();

 private:
  struct RunState;
  struct WaitState;

  // Contains the data needed to track a request to AddHandler().
  struct HandlerData {
    HandlerData()
        : handler(NULL),
          wait_flags(MOJO_WAIT_FLAG_NONE),
          deadline(0),
          id(0) {}

    RunLoopHandler* handler;
    MojoWaitFlags wait_flags;
    MojoTimeTicks deadline;
    // See description of |RunLoop::next_handler_id_| for details.
    int id;
  };

  typedef std::map<Handle, HandlerData> HandleToHandlerData;

  // Waits for a handle to be ready. Returns after servicing at least one
  // handle (or there are no more handles).
  void Wait();

  // Notifies any handlers whose deadline has expired.
  void NotifyDeadlineExceeded();

  // Removes the first invalid handle. This is called if MojoWaitMany() finds an
  // invalid handle.
  void RemoveFirstInvalidHandle(const WaitState& wait_state);

  // Returns the state needed to pass to WaitMany().
  WaitState GetWaitState() const;

  HandleToHandlerData handler_data_;

  // If non-NULL we're running (inside Run()). Member references a value on the
  // stack.
  RunState* run_state_;

  // An ever increasing value assigned to each HandlerData::id. Used to detect
  // uniqueness while notifying. That is, while notifying expired timers we copy
  // |handler_data_| and only notify handlers whose id match. If the id does not
  // match it means the handler was removed then added so that we shouldn't
  // notify it.
  int next_handler_id_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(RunLoop);
};

}  // namespace utility
}  // namespace mojo

#endif  // MOJO_PUBLIC_UTILITY_RUN_LOOP_H_

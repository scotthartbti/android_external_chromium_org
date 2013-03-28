# This file is generated by gyp; do not edit.

include $(CLEAR_VARS)

LOCAL_MODULE_CLASS := GYP
LOCAL_MODULE := media_media_android_jni_headers_gyp
LOCAL_MODULE_STEM := media_android_jni_headers
LOCAL_MODULE_SUFFIX := .stamp
LOCAL_MODULE_TAGS := optional
gyp_intermediate_dir := $(call local-intermediates-dir)
gyp_shared_intermediate_dir := $(call intermediates-dir-for,GYP,shared)

# Make sure our deps are built first.
GYP_TARGET_DEPENDENCIES := \
	$(call intermediates-dir-for,GYP,media_media_player_jni_headers_gyp)/media_player_jni_headers.stamp


### Generated for rule "media_media_gyp_media_android_jni_headers_target_generate_jni_headers":
# "{'inputs': ['../base/android/jni_generator/jni_generator.py'], 'process_outputs_as_sources': '1', 'extension': 'java', 'outputs': ['$(gyp_shared_intermediate_dir)/media/jni/%(INPUT_ROOT)s_jni.h'], 'rule_name': 'generate_jni_headers', 'rule_sources': ['base/android/java/src/org/chromium/media/AudioManagerAndroid.java', 'base/android/java/src/org/chromium/media/MediaPlayerBridge.java', 'base/android/java/src/org/chromium/media/MediaPlayerListener.java'], 'action': ['../base/android/jni_generator/jni_generator.py', '--input_file', '$(RULE_SOURCES)', '--output_dir', '$(gyp_shared_intermediate_dir)/media/jni', '--optimize_generation', '0'], 'message': 'Generating JNI bindings from $(RULE_SOURCES)'}":
$(gyp_shared_intermediate_dir)/media/jni/AudioManagerAndroid_jni.h: gyp_local_path := $(LOCAL_PATH)
$(gyp_shared_intermediate_dir)/media/jni/AudioManagerAndroid_jni.h: gyp_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_intermediate_dir)
$(gyp_shared_intermediate_dir)/media/jni/AudioManagerAndroid_jni.h: gyp_shared_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_shared_intermediate_dir)
$(gyp_shared_intermediate_dir)/media/jni/AudioManagerAndroid_jni.h: export PATH := $(subst $(ANDROID_BUILD_PATHS),,$(PATH))
$(gyp_shared_intermediate_dir)/media/jni/AudioManagerAndroid_jni.h: $(LOCAL_PATH)/media/base/android/java/src/org/chromium/media/AudioManagerAndroid.java $(LOCAL_PATH)/base/android/jni_generator/jni_generator.py $(GYP_TARGET_DEPENDENCIES)
	mkdir -p $(gyp_shared_intermediate_dir)/media/jni; cd $(gyp_local_path)/media; ../base/android/jni_generator/jni_generator.py --input_file base/android/java/src/org/chromium/media/AudioManagerAndroid.java --output_dir "$(gyp_shared_intermediate_dir)/media/jni" --optimize_generation 0

.PHONY: media_media_android_jni_headers_gyp_rule_trigger
media_media_android_jni_headers_gyp_rule_trigger: $(gyp_shared_intermediate_dir)/media/jni/AudioManagerAndroid_jni.h

$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerBridge_jni.h: gyp_local_path := $(LOCAL_PATH)
$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerBridge_jni.h: gyp_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_intermediate_dir)
$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerBridge_jni.h: gyp_shared_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_shared_intermediate_dir)
$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerBridge_jni.h: export PATH := $(subst $(ANDROID_BUILD_PATHS),,$(PATH))
$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerBridge_jni.h: $(LOCAL_PATH)/media/base/android/java/src/org/chromium/media/MediaPlayerBridge.java $(LOCAL_PATH)/base/android/jni_generator/jni_generator.py $(GYP_TARGET_DEPENDENCIES)
	mkdir -p $(gyp_shared_intermediate_dir)/media/jni; cd $(gyp_local_path)/media; ../base/android/jni_generator/jni_generator.py --input_file base/android/java/src/org/chromium/media/MediaPlayerBridge.java --output_dir "$(gyp_shared_intermediate_dir)/media/jni" --optimize_generation 0

.PHONY: media_media_android_jni_headers_gyp_rule_trigger
media_media_android_jni_headers_gyp_rule_trigger: $(gyp_shared_intermediate_dir)/media/jni/MediaPlayerBridge_jni.h

$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerListener_jni.h: gyp_local_path := $(LOCAL_PATH)
$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerListener_jni.h: gyp_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_intermediate_dir)
$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerListener_jni.h: gyp_shared_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_shared_intermediate_dir)
$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerListener_jni.h: export PATH := $(subst $(ANDROID_BUILD_PATHS),,$(PATH))
$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerListener_jni.h: $(LOCAL_PATH)/media/base/android/java/src/org/chromium/media/MediaPlayerListener.java $(LOCAL_PATH)/base/android/jni_generator/jni_generator.py $(GYP_TARGET_DEPENDENCIES)
	mkdir -p $(gyp_shared_intermediate_dir)/media/jni; cd $(gyp_local_path)/media; ../base/android/jni_generator/jni_generator.py --input_file base/android/java/src/org/chromium/media/MediaPlayerListener.java --output_dir "$(gyp_shared_intermediate_dir)/media/jni" --optimize_generation 0

.PHONY: media_media_android_jni_headers_gyp_rule_trigger
media_media_android_jni_headers_gyp_rule_trigger: $(gyp_shared_intermediate_dir)/media/jni/MediaPlayerListener_jni.h

### Finished generating for all rules

GYP_GENERATED_OUTPUTS := \
	$(gyp_shared_intermediate_dir)/media/jni/AudioManagerAndroid_jni.h \
	$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerBridge_jni.h \
	$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerListener_jni.h

# Make sure our deps and generated files are built first.
LOCAL_ADDITIONAL_DEPENDENCIES := $(GYP_TARGET_DEPENDENCIES) $(GYP_GENERATED_OUTPUTS)

LOCAL_GENERATED_SOURCES := \
	$(gyp_shared_intermediate_dir)/media/jni/AudioManagerAndroid_jni.h \
	$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerBridge_jni.h \
	$(gyp_shared_intermediate_dir)/media/jni/MediaPlayerListener_jni.h \
	media_media_android_jni_headers_gyp_rule_trigger

GYP_COPIED_SOURCE_ORIGIN_DIRS :=

LOCAL_SRC_FILES :=


# Flags passed to both C and C++ files.
MY_CFLAGS := \
	--param=ssp-buffer-size=4 \
	-Werror \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wall \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-m32 \
	-mmmx \
	-march=pentium4 \
	-msse2 \
	-mfpmath=sse \
	-ffunction-sections \
	-funwind-tables \
	-g \
	-fno-short-enums \
	-finline-limit=64 \
	-Wa,--noexecstack \
	-U_FORTIFY_SOURCE \
	-Wno-extra \
	-Wno-ignored-qualifiers \
	-Wno-type-limits \
	-fno-stack-protector \
	-Os \
	-g \
	-fomit-frame-pointer \
	-fdata-sections \
	-ffunction-sections

MY_CFLAGS_C :=

MY_DEFS := \
	'-DUSE_SKIA' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DUSE_LINUX_BREAKPAD' \
	'-DNO_TCMALLOC' \
	'-DDISABLE_NACL' \
	'-DCHROMIUM_BUILD' \
	'-DUSE_LIBJPEG_TURBO=1' \
	'-DUSE_PROPRIETARY_CODECS' \
	'-DENABLE_PEPPER_THREADING' \
	'-DENABLE_GPU=1' \
	'-DUSE_OPENSSL=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-DENABLE_LANGUAGE_DETECTION=1' \
	'-D__STDC_CONSTANT_MACROS' \
	'-D__STDC_FORMAT_MACROS' \
	'-DANDROID' \
	'-D__GNU_SOURCE=1' \
	'-DUSE_STLPORT=1' \
	'-D_STLP_USE_PTR_SPECIALIZATIONS=1' \
	'-DCHROME_BUILD_ID=""' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=1' \
	'-DWTF_USE_DYNAMIC_ANNOTATIONS=1' \
	'-D_DEBUG'

LOCAL_CFLAGS := $(MY_CFLAGS_C) $(MY_CFLAGS) $(MY_DEFS)

# Include paths placed before CFLAGS/CPPFLAGS
LOCAL_C_INCLUDES := \
	$(GYP_ABS_ANDROID_TOP_DIR)/frameworks/wilhelm/include \
	$(GYP_ABS_ANDROID_TOP_DIR)/bionic \
	$(GYP_ABS_ANDROID_TOP_DIR)/external/stlport/stlport

LOCAL_C_INCLUDES := $(GYP_COPIED_SOURCE_ORIGIN_DIRS) $(LOCAL_C_INCLUDES)

# Flags passed to only C++ (and not C) files.
LOCAL_CPPFLAGS := \
	-fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wsign-compare \
	-Wno-error=c++0x-compat \
	-Wno-non-virtual-dtor \
	-Wno-sign-promo

### Rules for final target.
# Add target alias to "gyp_all_modules" target.
.PHONY: gyp_all_modules
gyp_all_modules: media_media_android_jni_headers_gyp

# Alias gyp target name.
.PHONY: media_android_jni_headers
media_android_jni_headers: media_media_android_jni_headers_gyp

LOCAL_MODULE_PATH := $(PRODUCT_OUT)/gyp_stamp
LOCAL_UNINSTALLABLE_MODULE := true

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(LOCAL_ADDITIONAL_DEPENDENCIES)
	$(hide) echo "Gyp timestamp: $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) touch $@

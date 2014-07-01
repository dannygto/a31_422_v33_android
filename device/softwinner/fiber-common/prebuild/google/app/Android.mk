#
# Copyright (C) 2008 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#TODO: write a build template file to do this, and/or fold into multi_prebuilt.

LOCAL_PATH := $(my-dir)


###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := ChromeBookmarksSyncAdapter
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := ConfigUpdater
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := FaceLock
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_REQUIRED_MODULES := libfacelock_jni \
    detection/multi_pose_face_landmark_detectors.7/left_eye-y0-yi45-p0-pi45-r0-ri20.lg_32/full_model.bin \
    detection/multi_pose_face_landmark_detectors.7/nose_base-y0-yi45-p0-pi45-r0-ri20.lg_32/full_model.bin \
    detection/multi_pose_face_landmark_detectors.7/right_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-2/full_model.bin \
    detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-r0-ri30.4a-v24/full_model.bin \
    detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-rn30-ri30.5-v24/full_model.bin \
    detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-rp30-ri30.5-v24/full_model.bin \
    recognition/face.face.y0-y0-22-b-N/full_model.bin

include $(BUILD_PREBUILT)



###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GenieWidget
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GmsCore
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GoogleBackupTransport
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := platform

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GoogleCalendarSyncAdapter
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GoogleContactsSyncAdapter
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GoogleFeedback
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

# This binary is required for any Google application to work
# It MUST be installed on all devices
###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GoogleLoginService
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GooglePartnerSetup
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

# This binary is required for any Google application to work
# It MUST be installed on all devices
###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GoogleServicesFramework
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := GoogleTTS
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := PicoTts
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_REQUIRED_MODULES := \
     libpatts_engine_jni_api \
     libspeexwrapper \
     preferred-apps/google.xml

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := LatinImeDictionaryPack
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := LatinImeGoogle
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := LatinIME
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := MediaUploader
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := NetworkLocation
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := OneTimeInitializer
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := Phonesky
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := QuickSearchBox2
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_OVERRIDES_PACKAGES := QuickSearchBox
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
#include $(CLEAR_VARS)

#LOCAL_MODULE := SetupWizard
#LOCAL_MODULE_TAGS := optional
#LOCAL_OVERRIDES_PACKAGES := Provision
#LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
#LOCAL_MODULE_CLASS := APPS
#LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
#LOCAL_CERTIFICATE := PRESIGNED

#include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := Talk
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_REQUIRED_MODULES := libvideochat_jni libvideochat_stabilize

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := Talkback
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)

###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := VoiceSearchStub
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_REQUIRED_MODULES := libgoogle_endpointer_jni \
    libgoogle_recognizer_jni_l \
    en-US/endpointer_voicesearch.config \
    en-US/endpointer_dictation.config \
    en-US/ep_acoustic_model \
    en-US/metadata \
    en-US/acoustic_model \
    en-US/c_fst \
    en-US/clg \
    en-US/compile_grammar.config \
    en-US/contacts.abnf \
    en-US/dict \
    en-US/dictation.config \
    en-US/embed_phone_nn_model \
    en-US/embed_phone_nn_state_sym \
    en-US/endpointer_voicesearch.config \
    en-US/endpointer_dictation.config \
    en-US/ep_acoustic_model \
    en-US/g2p_fst \
    en-US/google_hotword.config \
    en-US/google_hotword_clg \
    en-US/google_hotword_logistic \
    en-US/hotword_symbols \
    en-US/grammar.config \
    en-US/hmmsyms \
    en-US/lintrans_model \
    en-US/normalizer \
    en-US/norm_fst \
    en-US/offensive_word_normalizer \
    en-US/phonelist \
    en-US/rescoring_lm \
    en-US/symbols \
    en-US/metadata


include $(BUILD_PREBUILT)





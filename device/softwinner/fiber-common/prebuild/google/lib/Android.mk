LOCAL_PATH := $(my-dir)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libfacelock_jni.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libfilterpack_facedetect.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libfrsdk.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libgcomm_jni.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libgoogle_recognizer_jni_l.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libgtalk_jni.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libgtalk_stabilize.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
ifeq ($(BUILD_GMS_PACKAGE),true)
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libjni_latinime.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)
endif
#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libjni_latinimegoogle.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libpatts_engine_jni_api.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libspeexwrapper.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libvorbisencoder.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT)


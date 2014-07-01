# Copyright (C) 2007 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)


include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    recovery.cpp \
    bootloader.cpp \
    install.cpp \
    roots.cpp \
    ui.cpp \
    screen_ui.cpp \
    verifier.cpp \
    adb_install.cpp

LOCAL_MODULE := recovery

LOCAL_FORCE_STATIC_EXECUTABLE := true

RECOVERY_API_VERSION := 3
LOCAL_CFLAGS += -DRECOVERY_API_VERSION=$(RECOVERY_API_VERSION)

LOCAL_STATIC_LIBRARIES := \
    libext4_utils_static \
    libsparse_static \
    libminzip \
    libz \
    libmtdutils \
    libmincrypt \
    libminadbd \
    libminui \
    libpixelflinger_static \
    libpng \
    libcutils \
    libstdc++ \
    libm \
    libc

ifeq ($(TARGET_USERIMAGES_USE_EXT4), true)
    LOCAL_CFLAGS += -DUSE_EXT4
    LOCAL_C_INCLUDES += system/extras/ext4_utils
    LOCAL_STATIC_LIBRARIES += libext4_utils_static libz
endif

ifeq ($(HAVE_SELINUX), true)
  LOCAL_C_INCLUDES += external/libselinux/include
  LOCAL_STATIC_LIBRARIES += libselinux
  LOCAL_CFLAGS += -DHAVE_SELINUX
endif # HAVE_SELINUX

# This binary is in the recovery ramdisk, which is otherwise a copy of root.
# It gets copied there in config/Makefile.  LOCAL_MODULE_TAGS suppresses
# a (redundant) copy of the binary in /system/bin for user builds.
# TODO: Build the ramdisk image in a more principled way.
LOCAL_MODULE_TAGS := eng

ifeq ($(TARGET_RECOVERY_UI_LIB),)
  LOCAL_SRC_FILES += default_device.cpp
else
  LOCAL_STATIC_LIBRARIES += $(TARGET_RECOVERY_UI_LIB)
endif

ifeq ($(SW_BOARD_TOUCH_RECOVERY),true)
LOCAL_CPPFLAGS += -DBOARD_TOUCH_RECOVERY
endif

ifneq ($(SW_BOARD_USE_CUSTOM_RECOVERY_FONT),)
   BOARD_USE_CUSTOM_RECOVERY_FONT :=$(SW_BOARD_USE_CUSTOM_RECOVERY_FONT)
else 
   BOARD_USE_CUSTOM_RECOVERY_FONT :=\"font_10x18.h\"
endif

ifneq ($(SW_BOARD_RECOVERY_CHAR_HEIGHT),)
   BOARD_RECOVERY_CHAR_HEIGHT :=$(SW_BOARD_RECOVERY_CHAR_HEIGHT)
else 
   BOARD_RECOVERY_CHAR_HEIGHT :=30
endif
ifneq ($(SW_BOARD_RECOVERY_CHAR_WIDTH),)
  BOARD_RECOVERY_CHAR_WIDTH  :=$(SW_BOARD_RECOVERY_CHAR_WIDTH)
else 
  BOARD_RECOVERY_CHAR_WIDTH  :=20
endif
ifneq ($(SW_BOARD_RECOVERY_ROTATION),)
  BOARD_RECOVERY_ROTATION  :=$(SW_BOARD_RECOVERY_ROTATION)
else
  BOARD_RECOVERY_ROTATION  :=0
endif
LOCAL_CPPFLAGS += -DBOARD_RECOVERY_ROTATION=$(BOARD_RECOVERY_ROTATION)
LOCAL_CPPFLAGS += -DBOARD_RECOVERY_CHAR_HEIGHT=$(BOARD_RECOVERY_CHAR_HEIGHT) -DBOARD_RECOVERY_CHAR_WIDTH=$(BOARD_RECOVERY_CHAR_WIDTH)
ifeq ($(HAVE_SELINUX),true)
  LOCAL_C_INCLUDES += external/libselinux/include
  LOCAL_STATIC_LIBRARIES += libselinux
  LOCAL_CFLAGS += -DHAVE_SELINUX
endif # HAVE_SELINUX

LOCAL_C_INCLUDES += system/extras/ext4_utils

include $(BUILD_EXECUTABLE)



include $(CLEAR_VARS)
LOCAL_MODULE := verifier_test
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_TAGS := tests
LOCAL_SRC_FILES := \
    verifier_test.cpp \
    verifier.cpp \
    ui.cpp
LOCAL_STATIC_LIBRARIES := \
    libmincrypt \
    libminui \
    libcutils \
    libstdc++ \
    libc
ifneq ($(SW_BOARD_RECOVERY_ROTATION),)
  BOARD_RECOVERY_ROTATION  :=$(SW_BOARD_RECOVERY_ROTATION)
else
  BOARD_RECOVERY_ROTATION  :=0
endif
LOCAL_CPPFLAGS += -DBOARD_RECOVERY_ROTATION=$(BOARD_RECOVERY_ROTATION)
include $(BUILD_EXECUTABLE)

# this is a debug tool
include $(CLEAR_VARS)

LOCAL_SRC_FILES := go_recovery.c
LOCAL_MODULE := go_recovery
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_TAGS := eng
LOCAL_STATIC_LIBRARIES := libstdc++ libc libcutils
include $(BUILD_EXECUTABLE)

include $(LOCAL_PATH)/minui/Android.mk \
    $(LOCAL_PATH)/minelf/Android.mk \
    $(LOCAL_PATH)/minzip/Android.mk \
    $(LOCAL_PATH)/minadbd/Android.mk \
    $(LOCAL_PATH)/mtdutils/Android.mk \
    $(LOCAL_PATH)/tools/Android.mk \
    $(LOCAL_PATH)/edify/Android.mk \
    $(LOCAL_PATH)/updater/Android.mk \
    $(LOCAL_PATH)/applypatch/Android.mk

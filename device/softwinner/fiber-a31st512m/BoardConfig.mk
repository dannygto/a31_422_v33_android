# BoardConfig.mk
#
# Product-specific compile-time definitions.
#

include device/softwinner/fiber-common/BoardConfigCommon.mk

# BOARD_KERNEL_CMDLINE += ion_reserve=96M
BOARD_KERNEL_CMDLINE += ion_reserve=48M

#recovery
TARGET_RECOVERY_UI_LIB := librecovery_ui_fiber_a31st512m
SW_BOARD_TOUCH_RECOVERY :=true
SW_BOARD_RECOVERY_CHAR_HEIGHT := 60
SW_BOARD_RECOVERY_CHAR_WIDTH  := 25
#/bootloader/recovery/minui/roboto_23x41.h,chose for change font size
SW_BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"

TARGET_NO_BOOTLOADER := true
TARGET_NO_RECOVERY := false
TARGET_NO_KERNEL := false

# 1. realtek wifi configuration
BOARD_WIFI_VENDOR := realtek
ifeq ($(BOARD_WIFI_VENDOR), realtek)
    WPA_SUPPLICANT_VERSION := VER_0_8_X
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_rtl
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_rtl

    SW_BOARD_USR_WIFI := rtl8188eu
    BOARD_WLAN_DEVICE := rtl8188eu

    #SW_BOARD_USR_WIFI := rtl8723as
    #BOARD_WLAN_DEVICE := rtl8723as

    #SW_BOARD_USR_WIFI := rtl8723au
    #BOARD_WLAN_DEVICE := rtl8723au

endif

BOARD_USES_GPS_TYPE := simulator

# may cause "android" bootanimation except
# TARGET_DISABLE_TRIPLE_BUFFERING := true

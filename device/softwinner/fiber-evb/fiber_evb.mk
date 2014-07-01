$(call inherit-product, device/softwinner/fiber-common/fiber-common.mk)
$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

# init.rc, kernel
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-evb/kernel:kernel \
	device/softwinner/fiber-evb/init.sun6i.rc:root/init.sun6i.rc \
	device/softwinner/fiber-evb/ueventd.sun6i.rc:root/ueventd.sun6i.rc \
	device/softwinner/fiber-evb/modules/modules/nand.ko:root/nand.ko \
	device/softwinner/fiber-evb/initlogo.rle:root/initlogo.rle \
	device/softwinner/fiber-evb/fstab.sun6i:root/fstab.sun6i \
	device/softwinner/fiber-evb/media/bootanimation.zip:system/media/bootanimation.zip \
	device/softwinner/fiber-evb/media/bootlogo.bmp:system/media/bootlogo.bmp \
	device/softwinner/fiber-evb/media/initlogo.bmp:system/media/initlogo.bmp \
	device/softwinner/fiber-evb/media/boot.wav:system/media/boot.wav \
	device/softwinner/fiber-evb/init.recovery.sun6i.rc:root/init.recovery.sun6i.rc

# GPU buffer size configs
PRODUCT_COPY_FILES += \
        device/softwinner/fiber-evb/configs/powervr.ini:system/etc/powervr.ini

#key and tp config file
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-evb/configs/sw-keyboard.kl:system/usr/keylayout/sw-keyboard.kl \
	device/softwinner/fiber-evb/configs/tp.idc:system/usr/idc/tp.idc \
	device/softwinner/fiber-evb/configs/gsensor.cfg:system/usr/gsensor.cfg

#copy touch and keyboard driver to recovery randisk
PRODUCT_COPY_FILES += \
  device/softwinner/fiber-evb/modules/modules/gt82x.ko:obj/touch.ko \
  device/softwinner/fiber-evb/modules/modules/sw-keyboard.ko:obj/keyboard.ko\
  device/softwinner/fiber-evb/modules/modules/disp.ko:obj/disp.ko\
  device/softwinner/fiber-evb/modules/modules/lcd.ko:obj/lcd.ko\
  device/softwinner/fiber-evb/modules/modules/hdmi.ko:obj/hdmi.ko

# wifi & bt config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    system/bluetooth/data/main.nonsmartphone.conf:system/etc/bluetooth/main.conf

# rtl8723as bt fw and config
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-common/hardware/realtek/bluetooth/rtl8723as/firmware/rtl8723as/rtl8723a_fw:system/etc/firmware/rtlbt/rtlbt_fw \
	device/softwinner/fiber-common/hardware/realtek/bluetooth/rtl8723as/firmware/rtl8723as/rtl8723a_config:system/etc/firmware/rtlbt/rtlbt_config

# rtl8723au bt fw and nvram
#PRODUCT_COPY_FILES += \
#  device/softwinner/fiber-common/hardware/realtek/bluetooth/rtl8723au/firmware/rtk8723au/rtk8723a:system/etc/firmware/rtk8723a \
#  device/softwinner/fiber-common/hardware/realtek/bluetooth/rtl8723au/firmware/rtk8723au/rtk8723_bt_config:system/etc/firmware/rtk8723_bt_config \
#  device/softwinner/fiber-common/hardware/realtek/bluetooth/rtl8723au/firmware/rtk8723au/rtk_btusb.ko:system/vendor/modules/rtk_btusb.ko

# ap6181 sdio wifi fw and nvram
#PRODUCT_COPY_FILES += \
#	hardware/broadcom/wlan/firmware/ap6181/fw_bcm40181a2_p2p.bin:system/vendor/modules/fw_bcm40181a2_p2p.bin \
#	hardware/broadcom/wlan/firmware/ap6181/fw_bcm40181a2_apsta.bin:system/vendor/modules/fw_bcm40181a2_apsta.bin \
#	hardware/broadcom/wlan/firmware/ap6181/fw_bcm40181a2.bin:system/vendor/modules/fw_bcm40181a2.bin \
#	hardware/broadcom/wlan/firmware/ap6181/nvram_ap6181.txt:system/vendor/modules/nvram_ap6181.txt

# ap6210 sdio wifi fw and nvram
#PRODUCT_COPY_FILES += \
#	hardware/broadcom/wlan/firmware/ap6210/fw_bcm40181a2.bin:system/vendor/modules/fw_bcm40181a2.bin \
#	hardware/broadcom/wlan/firmware/ap6210/fw_bcm40181a2_apsta.bin:system/vendor/modules/fw_bcm40181a2_apsta.bin \
#	hardware/broadcom/wlan/firmware/ap6210/fw_bcm40181a2_p2p.bin:system/vendor/modules/fw_bcm40181a2_p2p.bin \
#	hardware/broadcom/wlan/firmware/ap6210/nvram_ap6210.txt:system/vendor/modules/nvram_ap6210.txt \
#	hardware/broadcom/wlan/firmware/ap6210/bcm20710a1.hcd:system/vendor/modules/bcm20710a1.hcd

# ap6330 sdio wifi fw and nvram
#PRODUCT_COPY_FILES += \
#	hardware/broadcom/wlan/firmware/ap6330/fw_bcm40183b2_ag.bin:system/vendor/modules/fw_bcm40183b2_ag.bin \
#	hardware/broadcom/wlan/firmware/ap6330/fw_bcm40183b2_ag_apsta.bin:system/vendor/modules/fw_bcm40183b2_ag_apsta.bin \
#	hardware/broadcom/wlan/firmware/ap6330/fw_bcm40183b2_ag_p2p.bin:system/vendor/modules/fw_bcm40183b2_ag_p2p.bin \
#	hardware/broadcom/wlan/firmware/ap6330/nvram_ap6330.txt:system/vendor/modules/nvram_ap6330.txt \
#	hardware/broadcom/wlan/firmware/ap6330/bcm40183b2.hcd:system/vendor/modules/bcm40183b2.hcd \
#	hardware/broadcom/wlan/firmware/ap6330/bd_addr.txt:system/etc/firmware/bd_addr.txt

#vold config
PRODUCT_COPY_FILES += \
   device/softwinner/fiber-evb/vold.fstab:system/etc/vold.fstab \
   device/softwinner/fiber-evb/recovery.fstab:recovery.fstab

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.timezone=Asia/Shanghai \
	persist.sys.language=zh \
	persist.sys.country=CN

# camera
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-evb/configs/camera.cfg:system/etc/camera.cfg \
	device/softwinner/fiber-evb/configs/media_profiles.xml:system/etc/media_profiles.xml \
	device/softwinner/fiber-evb/configs/cfg-AWGallery.xml:system/etc/cfg-AWGallery.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml

# 3G Data Card Packages
PRODUCT_PACKAGES += \
	u3gmonitor \
	chat \
	rild \
	pppd

# 3G Data Card Configuration Flie
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-common/rild/ip-down:system/etc/ppp/ip-down \
	device/softwinner/fiber-common/rild/ip-up:system/etc/ppp/ip-up \
	device/softwinner/fiber-common/rild/3g_dongle.cfg:system/etc/3g_dongle.cfg \
	device/softwinner/fiber-common/rild/usb_modeswitch:system/bin/usb_modeswitch \
	device/softwinner/fiber-common/rild/call-pppd:system/xbin/call-pppd \
	device/softwinner/fiber-common/rild/usb_modeswitch.sh:system/xbin/usb_modeswitch.sh \
	device/softwinner/fiber-common/rild/apns-conf_sdk.xml:system/etc/apns-conf.xml \
	device/softwinner/fiber-common/rild/libsoftwinner-ril.so:system/lib/libsoftwinner-ril.so

# 3G Data Card usb modeswitch File
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/softwinner/fiber-common/rild/usb_modeswitch.d,system/etc/usb_modeswitch.d)

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160 \
	ro.sf.showhdmisettings=5 \
	ro.product.firmware=v3.3 \
	persist.sys.ui.hw=true \
	ro.product.8723.bt=use \
	persist.sys.usb.config=mass_storage,adb \
	ro.udisk.lable=fiber

$(call inherit-product-if-exists, device/softwinner/fiber-evb/modules/modules.mk)

DEVICE_PACKAGE_OVERLAYS := device/softwinner/fiber-evb/overlay
PRODUCT_CHARACTERISTICS := tablet

# Overrides
PRODUCT_BRAND  := softwinners
PRODUCT_NAME   := fiber_evb
PRODUCT_DEVICE := fiber-evb
PRODUCT_MODEL  := Softwiner




$(call inherit-product, device/softwinner/fiber-common/fiber-common.mk)
$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)

# init.rc, kernel
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31stm/kernel:kernel \
	device/softwinner/fiber-a31stm/modules/modules/nand.ko:root/nand.ko \
	device/softwinner/fiber-a31stm/init.sun6i.rc:root/init.sun6i.rc \
	device/softwinner/fiber-a31stm/ueventd.sun6i.rc:root/ueventd.sun6i.rc \
	device/softwinner/fiber-a31stm/initlogo.rle:root/initlogo.rle  \
	device/softwinner/fiber-a31stm/media/bootanimation.zip:system/media/bootanimation.zip \
	device/softwinner/fiber-a31stm/media/boot.wav:system/media/boot.wav \
	device/softwinner/fiber-a31stm/media/bootlogo.bmp:system/media/bootlogo.bmp \
	device/softwinner/fiber-a31stm/media/initlogo.bmp:system/media/initlogo.bmp \
	device/softwinner/fiber-a31stm/fstab.sun6i:root/fstab.sun6i \
	device/softwinner/fiber-a31stm/init.recovery.sun6i.rc:root/init.recovery.sun6i.rc

# wifi features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

# GPU buffer size configs
PRODUCT_COPY_FILES += \
        device/softwinner/fiber-a31stm/configs/powervr.ini:system/etc/powervr.ini

#key and tp config file
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31stm/configs/sw-keyboard.kl:system/usr/keylayout/sw-keyboard.kl \
	device/softwinner/fiber-a31stm/configs/tp.idc:system/usr/idc/tp.idc \
	device/softwinner/fiber-a31stm/configs/gsensor.cfg:system/usr/gsensor.cfg

#copy touch and keyboard driver to recovery randisk
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31stm/modules/modules/gslX680.ko:obj/touch.ko \
	device/softwinner/fiber-a31stm/modules/modules/sw-keyboard.ko:obj/keyboard.ko \
        device/softwinner/fiber-a31stm/modules/modules/disp.ko:obj/disp.ko \
        device/softwinner/fiber-a31stm/modules/modules/lcd.ko:obj/lcd.ko \
        device/softwinner/fiber-a31stm/modules/modules/hdmi.ko:obj/hdmi.ko
#vold config
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31stm/vold.fstab:system/etc/vold.fstab \
	device/softwinner/fiber-a31stm/recovery.fstab:recovery.fstab 
# camera
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31stm/configs/camera.cfg:system/etc/camera.cfg \
	device/softwinner/fiber-a31stm/configs/media_profiles.xml:system/etc/media_profiles.xml \
	device/softwinner/fiber-a31stm/configs/cfg-AWGallery.xml:system/etc/cfg-AWGallery.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml
# camera config for isp
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31stm/hawkview/ov5647/camera.ini:system/etc/hawkview/camera.ini \
	device/softwinner/fiber-a31stm/hawkview/ov5647/bin/gamma_tbl.bin:system/etc/hawkview/bin/gamma_tbl.bin \
	device/softwinner/fiber-a31stm/hawkview/ov5647/bin/hdr_tbl.bin:system/etc/hawkview/bin/hdr_tbl.bin \
	device/softwinner/fiber-a31stm/hawkview/ov5647/bin/lsc_tbl.bin:system/etc/hawkview/bin/lsc_tbl.bin

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

#4KPlayer
PRODUCT_COPY_FILES += \
       device/softwinner/fiber-a31stm/configs/cfg-fourkplayer.xml:system/etc/cfg-fourkplayer.xml

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.timezone=Asia/Shanghai \
	persist.sys.language=zh \
	persist.sys.country=CN

# a31st logger
PRODUCT_COPY_FILES += \
       device/softwinner/fiber-a31stm/tools/logger.sh:system/bin/logger.sh \
       device/softwinner/fiber-a31stm/tools/memtester:system/bin/memtester

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp,adb \
	ro.udisk.lable=FIBER \
	ro.font.scale=1.0 \
  rw.logger=1 \
  ro.sys.storage_type=emulated \
	ro.sys.bootfast=false

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160 \
	ro.product.firmware=v3.3

$(call inherit-product-if-exists, device/softwinner/fiber-a31stm/modules/modules.mk)

DEVICE_PACKAGE_OVERLAYS := device/softwinner/fiber-a31stm/overlay
PRODUCT_CHARACTERISTICS := tablet

# Overrides
PRODUCT_AAPT_CONFIG := xlarge hdpi xhdpi large
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_BRAND  := Allwinner-Tablet
PRODUCT_NAME   := fiber_a31stm
PRODUCT_DEVICE := fiber-a31stm
PRODUCT_MODEL  := Allwinner-Tablet

include device/softwinner/fiber-common/prebuild/google/products/gms.mk

# for ctsVerifier
PRODUCT_PACKAGES += \
       com.android.future.usb.accessory
PRODUCT_COPY_FILES += \
       frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
       frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml

# add widevin for gts
PRODUCT_PROPERTY_OVERRIDES += \
	drm.service.enabled=true
	
PRODUCT_PACKAGES += \
	com.google.widevine.software.drm.xml \
	com.google.widevine.software.drm \
	libdrmwvmplugin \
	libwvm \
	libWVStreamControlAPI_L3 \
	libwvdrm_L3 \
	libdrmdecrypt

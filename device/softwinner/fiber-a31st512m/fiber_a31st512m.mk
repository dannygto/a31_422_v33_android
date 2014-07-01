$(call inherit-product, device/softwinner/fiber-common/fiber-common.mk)
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# init.rc, kernel
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31st512m/kernel:kernel \
	device/softwinner/fiber-a31st512m/modules/modules/nand.ko:root/nand.ko \
	device/softwinner/fiber-a31st512m/init.sun6i.rc:root/init.sun6i.rc \
	device/softwinner/fiber-a31st512m/ueventd.sun6i.rc:root/ueventd.sun6i.rc \
	device/softwinner/fiber-a31st512m/initlogo.rle:root/initlogo.rle  \
	device/softwinner/fiber-a31st512m/media/bootanimation.zip:system/media/bootanimation.zip \
	device/softwinner/fiber-a31st512m/media/bootlogo.bmp:system/media/bootlogo.bmp \
	device/softwinner/fiber-a31st512m/media/initlogo.bmp:system/media/initlogo.bmp \
	device/softwinner/fiber-a31st512m/fstab.sun6i:root/fstab.sun6i \
        device/softwinner/fiber-a31st512m/init.recovery.sun6i.rc:root/init.recovery.sun6i.rc

# wifi features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

# GPU buffer size configs
PRODUCT_COPY_FILES += \
        device/softwinner/fiber-a31st512m/configs/powervr.ini:system/etc/powervr.ini

#key and tp config file
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31st512m/configs/sw-keyboard.kl:system/usr/keylayout/sw-keyboard.kl \
	device/softwinner/fiber-a31st512m/configs/tp.idc:system/usr/idc/tp.idc \
	device/softwinner/fiber-a31st512m/configs/gsensor.cfg:system/usr/gsensor.cfg

#copy touch and keyboard driver to recovery randisk
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31st512m/modules/modules/aw5306_ts.ko:obj/touch.ko \
	device/softwinner/fiber-a31st512m/modules/modules/sw-keyboard.ko:obj/keyboard.ko \
        device/softwinner/fiber-a31st512m/modules/modules/disp.ko:obj/disp.ko \
        device/softwinner/fiber-a31st512m/modules/modules/lcd.ko:obj/lcd.ko \
        device/softwinner/fiber-a31st512m/modules/modules/hdmi.ko:obj/hdmi.ko
#vold config
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31st512m/vold.fstab:system/etc/vold.fstab \
	device/softwinner/fiber-a31st512m/recovery.fstab:recovery.fstab 
# camera
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31st512m/configs/camera.cfg:system/etc/camera.cfg \
	device/softwinner/fiber-a31st512m/configs/media_profiles.xml:system/etc/media_profiles.xml \
	device/softwinner/fiber-a31st512m/configs/cfg-AWGallery.xml:system/etc/cfg-AWGallery.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml
# camera config for isp
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-a31st512m/hawkview/ov5647/camera.ini:system/etc/hawkview/camera.ini \
	device/softwinner/fiber-a31st512m/hawkview/ov5647/bin/gamma_tbl.bin:system/etc/hawkview/bin/gamma_tbl.bin \
	device/softwinner/fiber-a31st512m/hawkview/ov5647/bin/hdr_tbl.bin:system/etc/hawkview/bin/hdr_tbl.bin \
	device/softwinner/fiber-a31st512m/hawkview/ov5647/bin/lsc_tbl.bin:system/etc/hawkview/bin/lsc_tbl.bin


# hardware features, for some apps in google play need bluetooth, location, telephony
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

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
       device/softwinner/fiber-a31st512m/configs/cfg-fourkplayer.xml:system/etc/cfg-fourkplayer.xml

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.timezone=Asia/Shanghai \
	persist.sys.language=zh \
	persist.sys.country=CN

# a31st512m logger
PRODUCT_COPY_FILES += \
       device/softwinner/fiber-a31st512m/tools/logger.sh:system/bin/logger.sh \
       device/softwinner/fiber-a31st512m/tools/memtester:system/bin/memtester

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mass_storage,adb \
	ro.udisk.lable=FIBER \
	ro.font.scale=1.0 \
        ro.sys.bootfast=true

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160 \
	ro.sf.showhdmisettings=5 \
	ro.product.firmware=v3.3 \
	qemu.hw.mainkeys=0 \
	rw.logger=0

$(call inherit-product-if-exists, device/softwinner/fiber-a31st512m/modules/modules.mk)

DEVICE_PACKAGE_OVERLAYS := device/softwinner/fiber-a31st512m/overlay
PRODUCT_CHARACTERISTICS := tablet

# Overrides
# 1024x600
PRODUCT_AAPT_CONFIG := normal large mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

PRODUCT_BRAND  := Allwinner-Tablet
PRODUCT_NAME   := fiber_a31st512m
PRODUCT_DEVICE := fiber-a31st512m
PRODUCT_MODEL  := Allwinner-Tablet
PRODUCT_MANUFACTURER := Allwinner

include device/softwinner/fiber-common/prebuild/google/products/gms.mk

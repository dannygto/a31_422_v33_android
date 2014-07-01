$(call inherit-product, device/softwinner/fiber-common/fiber-common.mk)
$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

#$(call inherit-product, device/softwinner/fiber-3g/ril_modem/Oviphone/em55/oviphone_em55.mk)
$(call inherit-product, device/softwinner/fiber-3g/ril_modem/huawei/mu509/huawei_mu509.mk)
#$(call inherit-product, device/softwinner/fiber-3g/ril_modem/yuga/cwm600/yuga_cwm600.mk)
#$(call inherit-product, device/softwinner/fiber-3g/ril_modem/longcheer/wm5608/longcheer_wm5608.mk)
#$(call inherit-product, device/softwinner/fiber-3g/ril_modem/spreadwin/g3/spw_g3.mk)
#$(call inherit-product, device/softwinner/fiber-3g/ril_modem/usi/mt6276/usi_mt6276.mk)
# init.rc, kernel
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-3g/kernel:kernel \
	device/softwinner/fiber-3g/init.sun6i.rc:root/init.sun6i.rc \
	device/softwinner/fiber-3g/ueventd.sun6i.rc:root/ueventd.sun6i.rc \
	device/softwinner/fiber-3g/modules/modules/nand.ko:root/nand.ko \
	device/softwinner/fiber-3g/initlogo.rle:root/initlogo.rle \
	device/softwinner/fiber-3g/fstab.sun6i:root/fstab.sun6i \
	device/softwinner/fiber-3g/media/bootanimation.zip:system/media/bootanimation.zip \
	device/softwinner/fiber-3g/media/boot.wav:system/media/boot.wav \
	device/softwinner/fiber-3g/init.recovery.sun6i.rc:root/init.recovery.sun6i.rc

# GPU buffer size configs
PRODUCT_COPY_FILES += \
        device/softwinner/fiber-3g/configs/powervr.ini:system/etc/powervr.ini

#key and tp config file
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-3g/configs/sw-keyboard.kl:system/usr/keylayout/sw-keyboard.kl \
	device/softwinner/fiber-3g/configs/tp.idc:system/usr/idc/tp.idc \
	device/softwinner/fiber-3g/configs/gsensor.cfg:system/usr/gsensor.cfg

#copy touch and keyboard driver to recovery randisk
PRODUCT_COPY_FILES += \
  device/softwinner/fiber-3g/modules/modules/gt82x.ko:obj/touch.ko \
  device/softwinner/fiber-3g/modules/modules/sw-keyboard.ko:obj/keyboard.ko\
  device/softwinner/fiber-3g/modules/modules/disp.ko:obj/disp.ko\
  device/softwinner/fiber-3g/modules/modules/lcd.ko:obj/lcd.ko\
  device/softwinner/fiber-3g/modules/modules/hdmi.ko:obj/hdmi.ko

# wifi & bt config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml

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
   device/softwinner/fiber-3g/vold.fstab:system/etc/vold.fstab \
   device/softwinner/fiber-3g/recovery.fstab:recovery.fstab

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.timezone=Asia/Shanghai \
	persist.sys.language=zh \
	persist.sys.country=CN

# camera
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-3g/configs/camera.cfg:system/etc/camera.cfg \
	device/softwinner/fiber-3g/configs/media_profiles.xml:system/etc/media_profiles.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml

# 3G Modem Packages
PRODUCT_PACKAGES += \
	chat \
	rild \
	Mms \
	pppd \
	Stk


PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160 \
	ro.sf.showhdmisettings=5 \
	ro.product.firmware=v3.3 \
	persist.sys.usb.config=mtp,adb \
	ro.udisk.lable=fiber

PRODUCT_PROPERTY_OVERRIDES += \
	rild.libpath=libsoftwinner-ril-huawei-mu509.so \
	ro.ril.ecclist=110,119,120,112,114,911 \
	audio.without.earpiece=1 \
	ro.sw.embeded.telephony=true \
	ro.sw.audio.codec_plan_name=PLAN_ONE

$(call inherit-product-if-exists, device/softwinner/fiber-3g/modules/modules.mk)

DEVICE_PACKAGE_OVERLAYS := device/softwinner/fiber-3g/overlay
PRODUCT_CHARACTERISTICS := tablet

# Overrides
PRODUCT_BRAND  := Softwinner
PRODUCT_NAME   := fiber_3g
PRODUCT_DEVICE := fiber-3g
PRODUCT_MODEL  := Softwinner


$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

include device/softwinner/fiber-common/prebuild/tools/tools.mk

# ext4 filesystem utils
PRODUCT_PACKAGES += \
	e2fsck \
	libext2fs \
	libext2_blkid \
	libext2_uuid \
	libext2_profile \
	libext2_com_err \
	libext2_e2p \
	make_ext4fs 

PRODUCT_PACKAGES += \
	audio.primary.fiber \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default

PRODUCT_PACKAGES += \
	libcedarxbase \
	libcedarxosal \
	libcedarv \
	libcedarv_base \
	libcedarv_adapter \
	libve \
	libaw_audio \
	libaw_audioa \
	libswdrm \
	libstagefright_soft_cedar_h264dec \
	libfacedetection \
	libthirdpartstream \
	libcedarxsftstream \
	libsunxi_alloc \
	libsrec_jni \
	libjpgenc \
	libstagefrighthw \
	libOmxCore \
	libOmxVdec \
	libOmxVenc \
	libaw_h264enc \
	libI420colorconvert \
	libcnr

PRODUCT_COPY_FILES += \
	device/softwinner/fiber-common/media_codecs.xml:system/etc/media_codecs.xml \
	device/softwinner/fiber-common/hardware/audio/audio_policy.conf:system/etc/audio_policy.conf \
	device/softwinner/fiber-common/hardware/audio/phone_volume.conf:system/etc/phone_volume.conf

# wfd no invite
PRODUCT_COPY_FILES += \
    device/softwinner/fiber-common/wfd_blacklist.conf:system/etc/wfd_blacklist.conf

#exdroid HAL
PRODUCT_PACKAGES += \
   lights.fiber \
   camera.fiber \
   sensors.fiber \
   gps.fiber

#install apk to system/app 
PRODUCT_PACKAGES +=  \
   Update \
   Google_maps \
   FileExplore \
   4KPlayer \
   FactoryTest \
   AWGallery \
   BDVideoHD \
   com.google.android.inputmethod.pinyin_403232 \
   libjni_mosaic \
   libjni_eglfence
   
#install apk's lib to system/lib
PRODUCT_PACKAGES +=  \
   libjni_googlepinyinime_latinime_5.so \
   libjni_googlepinyinime_5.so \
   libjni_delight.so \
   libjni_hmm_shared_engine.so \
   libgnustl_shared.so \
   libcyberplayer.so \
   libffmpeg.so \
   libgetcpuspec.so \
   libp2p-jni.so \
   libstlport_shared.so
	
#preinstall apk
PRODUCT_PACKAGES += \
  flashplayer.apk \
  DragonFire_v2.1.apk \
  DragonPhone.apk

# init.rc
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-common/init.rc:root/init.rc \
	device/softwinner/fiber-common/init.sun6i.usb.rc:root/init.sun6i.usb.rc

# table core hardware
PRODUCT_COPY_FILES += \
    device/softwinner/fiber-common/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml
    
# softwinner	
PRODUCT_PACKAGES +=  \
   android.softwinner.framework.jar \
   SoftWinnerService.apk \
   backup/SoftWinnerService.apk \
   libsoftwinner_servers.so \
   libupdatesoftwinner.so \
   updatesoftwinner 

#egl
PRODUCT_COPY_FILES += \
       device/softwinner/fiber-common/egl/pvrsrvctl:system/vendor/bin/pvrsrvctl \
       device/softwinner/fiber-common/egl/libusc.so:system/vendor/lib/libusc.so \
       device/softwinner/fiber-common/egl/libglslcompiler.so:system/vendor/lib/libglslcompiler.so \
       device/softwinner/fiber-common/egl/libIMGegl.so:system/vendor/lib/libIMGegl.so \
       device/softwinner/fiber-common/egl/libpvr2d.so:system/vendor/lib/libpvr2d.so \
       device/softwinner/fiber-common/egl/libpvrANDROID_WSEGL.so:system/vendor/lib/libpvrANDROID_WSEGL.so \
       device/softwinner/fiber-common/egl/libPVRScopeServices.so:system/vendor/lib/libPVRScopeServices.so \
       device/softwinner/fiber-common/egl/libsrv_init.so:system/vendor/lib/libsrv_init.so \
       device/softwinner/fiber-common/egl/libsrv_um.so:system/vendor/lib/libsrv_um.so \
       device/softwinner/fiber-common/egl/libEGL_POWERVR_SGX544_115.so:system/vendor/lib/egl/libEGL_POWERVR_SGX544_115.so \
       device/softwinner/fiber-common/egl/libGLESv1_CM_POWERVR_SGX544_115.so:system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX544_115.so \
       device/softwinner/fiber-common/egl/libGLESv2_POWERVR_SGX544_115.so:system/vendor/lib/egl/libGLESv2_POWERVR_SGX544_115.so \
       device/softwinner/fiber-common/egl/gralloc.sun6i.so:system/vendor/lib/hw/gralloc.sun6i.so \
       device/softwinner/fiber-common/egl/hwcomposer.sun6i.so:system/vendor/lib/hw/hwcomposer.sun6i.so \
       device/softwinner/fiber-common/egl/egl.cfg:system/lib/egl/egl.cfg \
       device/softwinner/fiber-common/sensors.sh:system/bin/sensors.sh

# cedar crack lib so
PRODUCT_COPY_FILES += \
        device/softwinner/fiber-common/CedarX-Crack/libdemux_rmvb.so:system/lib/libdemux_rmvb.so \
        device/softwinner/fiber-common/CedarX-Crack/librm.so:system/lib/librm.so \
        device/softwinner/fiber-common/CedarX-Crack/libswa1.so:system/lib/libswa1.so \
        device/softwinner/fiber-common/CedarX-Crack/libswa2.so:system/lib/libswa2.so


PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.strictmode.visual=0 \
	persist.sys.strictmode.disable=1

PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072

PRODUCT_PROPERTY_OVERRIDES += \
	ro.kernel.android.checkjni=0

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PROPERTY_OVERRIDES += \
	ro.reversion.aw_sdk_tag=exdroid4.2.2_r1-a31-v3.3 \
	ro.sys.cputype=QuadCore-A31Series

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=15 \
	keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
	persist.demo.hdmirotationlock=0
	
BUILD_NUMBER := $(shell date +%Y%m%d)

#pppoe
PRODUCT_PACKAGES += \
    PPPoEService
PRODUCT_COPY_FILES += \
	external/ppp/pppoe/script/ip-up-pppoe:system/etc/ppp/ip-up-pppoe \
	external/ppp/pppoe/script/ip-down-pppoe:system/etc/ppp/ip-down-pppoe \
	external/ppp/pppoe/script/pppoe-connect:system/bin/pppoe-connect \
	external/ppp/pppoe/script/pppoe-disconnect:system/bin/pppoe-disconnect

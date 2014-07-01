# spreadwin g3 Configuration Flie
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-common/rild/ip-down:system/etc/ppp/ip-down \
	device/softwinner/fiber-common/rild/ip-up:system/etc/ppp/ip-up \
	device/softwinner/fiber-common/rild/call-pppd:system/etc/ppp/call-pppd \
	device/softwinner/fiber-common/rild/apns-conf_sdk.xml:system/etc/apns-conf.xml \
	device/softwinner/fiber-3g/ril_modem/spreadwin/g3/hspa-pppd:system/etc/ppp/hspa-pppd \
	device/softwinner/fiber-3g/ril_modem/spreadwin/g3/libg3-ril.so:system/lib/libg3-ril.so

PRODUCT_COPY_FILES += \
	device/softwinner/fiber-3g/ril_modem/spreadwin/g3/init.spw_g3.rc:root/init.sun6i.3g.rc

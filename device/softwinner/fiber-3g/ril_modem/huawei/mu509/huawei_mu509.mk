# 3G Modem Configuration Flie
PRODUCT_COPY_FILES += \
	device/softwinner/fiber-common/rild/ip-down:system/etc/ppp/ip-down \
	device/softwinner/fiber-common/rild/ip-up:system/etc/ppp/ip-up \
	device/softwinner/fiber-common/rild/call-pppd:system/etc/ppp/call-pppd \
	device/softwinner/fiber-common/rild/apns-conf_sdk.xml:system/etc/apns-conf.xml \
	device/softwinner/fiber-3g/ril_modem/huawei/mu509/libsoftwinner-ril-huawei-mu509.so:system/lib/libsoftwinner-ril-huawei-mu509.so

PRODUCT_COPY_FILES += \
	device/softwinner/fiber-3g/ril_modem/huawei/mu509/init.huawei_mu509.rc:root/init.sun6i.3g.rc

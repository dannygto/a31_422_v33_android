# Add Google Apps and Services
PRODUCT_PACKAGES += \
     ChromeBookmarksSyncAdapter \
     ConfigUpdater \
     FaceLock \
     GenieWidget \
     GoogleBackupTransport \
     GoogleCalendarSyncAdapter \
     GoogleContactsSyncAdapter \
     GoogleFeedback \
     GmsCore \
     GoogleLoginService \
     GooglePartnerSetup \
     GoogleServicesFramework \
     LatinImeDictionaryPack \
	 LatinImeGoogle \
     MediaUploader \
     NetworkLocation \
     OneTimeInitializer \
     Phonesky \
     QuickSearchBox2 \
     Talk \
     Talkback \
     VoiceSearchStub

#Add for the user tha we don't know  now      
PRODUCT_PACKAGES += \
     com.google.android.media.effects.jar \
     com.google.android.maps.jar \
     com.google.widevine.software.drm.jar \
     google_generic_update.txt \
     features.xml \
     g.prop \
     libgtalk_jni \
     libgtalk_stabilize \
	 libjni_latinimegoogle \
     libvorbisencoder \
     libgcomm_jni


# Add in the Google version of the platform apps

     
# Include GoogleTTS and TTS languages needed for GoogleTTS
PRODUCT_PACKAGES += GoogleTTS
include device/softwinner/fiber-common/prebuild/google/products/text_to_speech_languages.mk 

# Overrides
PRODUCT_PROPERTY_OVERRIDES += \
     ro.setupwizard.mode=OPTIONAL \
     ro.com.google.gmsversion=4.2.2

BUILD_GMS_PACKAGE := true

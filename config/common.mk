PRODUCT_BRAND ?= cyanogenmod

ifdef CM_NIGHTLY
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=flarerom
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=flarerom
endif

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/cm/CHANGELOG.mkdn:system/etc/Changelog.txt

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cm/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cm/prebuilt/common/bin/50-cm.sh:system/addon.d/50-cm.sh \
    vendor/cm/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/cm/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# CM-specific init file
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is CM!
PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Theme engine
include vendor/cm/config/themes_common.mk

# CMSDK
include vendor/cm/config/cmsdk_common.mk

# Required CM packages
PRODUCT_PACKAGES += \
    Development \
    BluetoothExt \
    Profiles

# Optional CM packages
PRODUCT_PACKAGES += \
    libemoji \
    Terminal

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Custom CM packages
PRODUCT_PACKAGES += \
    Launcher3 \
    Trebuchet \
    CMWallpapers \
    CMFileManager \
    Eleven \
    LockClock \
    CMUpdater \
    CyanogenSetupWizard \
    CMSettingsProvider \
    ExactCalculator \
    LiveLockScreenService \
    WeatherProvider \
    DataUsageProvider

# OmniROM packages
PRODUCT_PACKAGES += \
    OmniSwitch

# FlareROM packages
PRODUCT_PACKAGES += \
    FlareROM_OTA

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in CM
PRODUCT_PACKAGES += \
    libsepol \
    mke2fs \
    tune2fs \
    nano \
    htop \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    pigz

WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su
endif

# V4A files
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/V4A/etc/audio_effects.conf:system/etc/audio_effects.conf \
    vendor/cm/prebuilt/V4A/lib/soundfx/libeffectproxy.so:system/lib/soundfx/libeffectproxy.so \
    vendor/cm/prebuilt/V4A/lib/soundfx/libv4a_fx_ics.so:system/lib/soundfx/libv4a_fx_ics.so \
    vendor/cm/prebuilt/V4A/priv-app/ViPER4Android/ViPER4Android.apk:system/priv-app/ViPER4Android/ViPER4Android.apk \
    vendor/cm/prebuilt/V4A/vendor/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf
	
# AdAway App  
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/AdAway/AdAway.apk:system/priv-app/AdAway/AdAway.apk
  
# KernelAdiutor  
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/KernelAdiutor/KernelAdiutor.apk:system/app/KernelAdiutor/KernelAdiutor.apk
	
# FlareROM optimization 
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/S86battery:system/etc/init.d/S86battery \
    vendor/cm/prebuilt/common/etc/init.d/S89touch:system/etc/init.d/S89touch

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

DEVICE_PACKAGE_OVERLAYS += vendor/cm/overlay/common

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0-RC0
FLAREROM_VERSION_THREE = 8

# Set CM_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef CM_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "CM_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^CM_||g')
        CM_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(CM_BUILDTYPE)),)
    CM_BUILDTYPE :=
endif

ifdef CM_BUILDTYPE
    ifneq ($(CM_BUILDTYPE), SNAPSHOT)
        ifdef CM_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            CM_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from CM_EXTRAVERSION
            CM_EXTRAVERSION := $(shell echo $(CM_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to CM_EXTRAVERSION
            CM_EXTRAVERSION := -$(CM_EXTRAVERSION)
        endif
    else
        ifndef CM_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            CM_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from CM_EXTRAVERSION
            CM_EXTRAVERSION := $(shell echo $(CM_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to CM_EXTRAVERSION
            CM_EXTRAVERSION := -$(CM_EXTRAVERSION)
        endif
    endif
else
    # If CM_BUILDTYPE is not defined, set to BETA
    CM_BUILDTYPE := BETA
    CM_EXTRAVERSION :=
endif

ifeq ($(CM_BUILDTYPE), BETA)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        CM_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(CM_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CM_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(CM_BUILD)
        else
            CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CM_BUILD)
        endif
    endif
else
    CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(FLAREROM_VERSION_THREE).$(CM_BUILDTYPE)-$(shell date -u +%Y%m%d)-$(CM_BUILD)
    FLAREROM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(FLAREROM_VERSION_THREE).$(CM_BUILDTYPE)-$(shell date -u +%Y%m%d)
	FLAREROM_OTA_VERSION := $(PRODUCT_VERSION_MAJOR)$(PRODUCT_VERSION_MINOR)$(FLAREROM_VERSION_THREE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.version=$(CM_VERSION) \
  ro.cm.releasetype=$(CM_BUILDTYPE) \
  ro.modversion=$(CM_VERSION) \
  ro.cmlegal.url=https://cyngn.com/legal/privacy-policy

# FlareROM
PRODUCT_PROPERTY_OVERRIDES += \
  ro.flarerom.version=$(FLAREROM_VERSION)
  
PRODUCT_PROPERTY_OVERRIDES += \
  ro.ota.version=$(FLAREROM_OTA_VERSION)  

# FlareROM optimization
PRODUCT_PROPERTY_OVERRIDES += \
  ro.HOME_APP_ADJ=1

PRODUCT_PROPERTY_OVERRIDES += \
  ro.HorizontalVVM=true

PRODUCT_PROPERTY_OVERRIDES += \
  ro.media.enc.hprof.vid.bps=41943040

PRODUCT_PROPERTY_OVERRIDES += \
  ro.media.enc.hprof.vid.fps=60

PRODUCT_PROPERTY_OVERRIDES += \
  debug.sf.hw=1

PRODUCT_PROPERTY_OVERRIDES += \
  ro.min_pointer_dur=10

PRODUCT_PROPERTY_OVERRIDES += \
  ro.telephony.call_ring.delay=1000

PRODUCT_PROPERTY_OVERRIDES += \
  windowsmgr.max_events_per_sec=80

PRODUCT_PROPERTY_OVERRIDES += \
  video.accelerate.hw=1

PRODUCT_PROPERTY_OVERRIDES += \
  debug.performance.tuning=1

PRODUCT_PROPERTY_OVERRIDES += \
  debug.buttonfast.delay=0

PRODUCT_PROPERTY_OVERRIDES += \
  ro.media.enc.jpeg.quality=100

PRODUCT_PROPERTY_OVERRIDES += \
  pm.sleep_mode=1

PRODUCT_PROPERTY_OVERRIDES += \
  ro.ril.disable.power.collapse=0

PRODUCT_PROPERTY_OVERRIDES += \
  ro.media.dec.jpeg.memcap=8000000

PRODUCT_PROPERTY_OVERRIDES += \
  ro.lge.proximity.delay=25

PRODUCT_PROPERTY_OVERRIDES += \
  ro.ril.spender.bending=1

PRODUCT_PROPERTY_OVERRIDES += \
  ro.ril.music_echo_sound=12

PRODUCT_PROPERTY_OVERRIDES += \
  ril.category.delay=0

PRODUCT_PROPERTY_OVERRIDES += \
  debug.kill_allocating_task=0

-include vendor/cm-priv/keys/keys.mk

CM_DISPLAY_VERSION := $(CM_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
  ifneq ($(CM_BUILDTYPE), UNOFFICIAL)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
      ifneq ($(CM_EXTRAVERSION),)
        # Remove leading dash from CM_EXTRAVERSION
        CM_EXTRAVERSION := $(shell echo $(CM_EXTRAVERSION) | sed 's/-//')
        TARGET_VENDOR_RELEASE_BUILD_ID := $(CM_EXTRAVERSION)
      else
        TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
      endif
    else
      TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
    endif
    CM_DISPLAY_VERSION=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(FLAREROM_VERSION_THREE).$(CM_BUILDTYPE)-$(shell date -u +%Y%m%d)
  endif
endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.display.version=$(CM_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk

-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)

#
# Copyright (C) 2021 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/realme/RMX1941

# Do not spin up a separate process for the network stack, use an in-process APK.
PRODUCT_PACKAGES += InProcessNetworkStack
PRODUCT_PACKAGES += com.android.tethering.inprocess

# Reduce system image size by limiting java debug info.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Always preopt extracted APKs to prevent extracting out of the APK
# for gms modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 29
PRODUCT_EXTRA_VNDK_VERSIONS := 29
PRODUCT_SHIPPING_API_LEVEL := 29

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Audio 
PRODUCT_COPY_FILES += \
  $(DEVICE_PATH)/configs/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_ODM)/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/configs/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/configs/audio/audio_effects.conf:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_effects.conf \
  $(DEVICE_PATH)/configs/audio/audio_effects.conf:$(TARGET_COPY_OUT_ODM)/etc/audio_effects.conf

# APNs
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/apns-conf.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/apns-conf.xml
    
# DT2W
PRODUCT_PACKAGES += \
    DT2W-Service-RMX1941

# Dependencies of kpoc_charger
PRODUCT_PACKAGES += \
    libsuspend \
    android.hardware.health@2.0

# FSTAB
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6765:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6765
    
# GCamGO
PRODUCT_PACKAGES += \
    CameraGo

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0_system \
    android.hidl.manager@1.0_system \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder \
    libhwbinder.vendor
    
# ImsInit hack
PRODUCT_PACKAGES += \
    ImsInit

# Input/DT2W
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/keylayout/touchpanel.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/touchpanel.kl \
    $(DEVICE_PATH)/configs/keylayout/ACCDET.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/ACCDET.kl \
    $(DEVICE_PATH)/configs/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.RMX1941

# MediaTek FMRadio
PRODUCT_PACKAGES += \
    FMRadio

# NotchBarKiller 
PRODUCT_PACKAGES += \
    NotchBarKiller

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-lineage \
    $(DEVICE_PATH)/overlay-xd

# Overlays -- replace official
PRODUCT_PACKAGES += \
    FrameworkResOverlay

# Permissions
PRODUCT_COPY_FILES := \
	$(DEVICE_PATH)/configs/permissions/com.mediatek.op.ims.common.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.mediatek.op.ims.common.xml \
	$(DEVICE_PATH)/configs/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
	$(DEVICE_PATH)/configs/permissions/privapp-permissions-oppo.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-oppo.xml \
	$(DEVICE_PATH)/configs/permissions/privapp-permissions-platform.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-platform.xml \
	$(DEVICE_PATH)/configs/permissions/platform.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/platform.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.ims.xml 

# Privapp-permissions whitelist
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-mediatek.xml:system/etc/permissions/privapp-permissions-mediatek.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-com.android.launcher3.xml:system/system_ext/etc/permissions/privapp-permissions-com.android.launcher3.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-oppo.xml:system/system_ext/etc/permissions/privapp-permissions-oppo.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-com.mediatek.ims.xml:system/etc/permissions/privapp-permissions-com.mediatek.ims.xml

# Ramdisk
PRODUCT_PACKAGES += \
    init.mt6765.rc \
    fstab.mt6765

# Realme
PRODUCT_PACKAGES += \
    RealmeParts

PRODUCT_PACKAGES += \
    parts.rc \
    perf_profile.sh

# RcsService
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    PresencePolling \
    RcsService

# Symbols
PRODUCT_PACKAGES += \
    libshim_showlogo

# Screen density
PRODUCT_AAPT_CONFIG := xxxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Trustonic TEE
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/public.libraries-trustonic.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/public.libraries-trustonic.txt

# Telephony
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common
    
PRODUCT_PACKAGES += \
    ImsServiceBase

# Tethering
PRODUCT_PACKAGES += \
    TetheringConfigOverlay

# WiFi
PRODUCT_PACKAGES += \
    WifiOverlay

# Properties
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true
-include $(DEVICE_PATH)/configs/mtk_services_log.mk

# Inherit Device Vendor
$(call inherit-product, vendor/realme/RMX1941/RMX1941-vendor.mk)

#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

## Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/samsung/hltedcm/hltedcm-vendor.mk)

## overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/hltedcm/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Audio configuration
PRODUCT_COPY_FILES += \
    device/samsung/hltedcm/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/samsung/hltedcm/audio/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/samsung/hltedcm/audio/audio_policy.conf:system/etc/audio_policy.conf \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

PRODUCT_PROPERTY_OVERRIDES += \
    af.resampler.quality=4 \
    audio.offload.buffer.size.kb=32 \
    audio.offload.gapless.enabled=false

# Default locale
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.locale.language=ja \
    ro.product.locale.region=JP

# Thermal config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf

# Media Profile
PRODUCT_COPY_FILES += \
    device/samsung/hltedcm/media/media_profiles.xml:system/etc/media_profiles.xml

# Extended media support
PRODUCT_PACKAGES += \
    qcmediaplayer

PRODUCT_BOOT_JARS += qcmediaplayer

# support for epen
PRODUCT_COPY_FILES += \
    device/samsung/hltedcm/sec_e-pen.idc:system/usr/idc/sec_e-pen.idc

# GPS
PRODUCT_PACKAGES += \
    gps.msm8974 \
    libgps.utils \
    libloc_core \
    libloc_eng

GPS_CONF := device/samsung/hltedcm/gps/etc/gps.conf

PRODUCT_COPY_FILES += \
    $(GPS_CONF):/system/etc/gps.conf \
    device/samsung/hltedcm/gps/etc/sap.conf:/system/etc/sap.conf

# Keylayouts
PRODUCT_COPY_FILES += \
    device/samsung/hltedcm/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    device/samsung/hltedcm/keylayout/Button_Jack.kl:system/usr/keylayout/Button_Jack.kl \
    device/samsung/hltedcm/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/samsung/hltedcm/keylayout/philips_remote_ir.kl:system/usr/keylayout/philips_remote_ir.kl \
    device/samsung/hltedcm/keylayout/samsung_remote_ir.kl:system/usr/keylayout/samsung_remote_ir.kl \
    device/samsung/hltedcm/keylayout/sec_touchkey.kl:system/usr/keylayout/sec_touchkey.kl \
    device/samsung/hltedcm/keylayout/ue_rf4ce_remote.kl:system/usr/keylayout/ue_rf4ce_remote.kl

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    initlogo.rle \
    init.bt.rc \
    init.carrier.rc \
    init.crda.sh \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.ril.rc \
    init.target.rc \
    ueventd.qcom.rc

# Audio
PRODUCT_PACKAGES += \
    audiod \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    tinymix

# Torch
PRODUCT_PACKAGES += Torch

# Wifi
PRODUCT_PACKAGES += \
    libnetcmdiface \
    macloader \
    crda \
    regulatory.bin \
    linville.key.pub.pem

# libxml2 is needed for camera
PRODUCT_PACKAGES += libxml2

# IR packages
PRODUCT_PACKAGES += \
    consumerir.msm8974
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml

# Nfc
NFCEE_ACCESS_PATH := device/samsung/hltedcm/nfc/nfcee_access.xml

ifeq ($(TARGET_NFC_TECH), nxp)
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

else

PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8974 \
    NfcNci \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml \
    device/samsung/hltedcm/nfc/libnfc-brcm-20791b05.conf:system/etc/libnfc-brcm-20791b05.conf \
    device/samsung/hltedcm/nfc/libnfc-brcm-20791b04.conf:system/etc/libnfc-brcm-20791b04.conf \
    device/samsung/hltedcm/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf

endif

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Lights
PRODUCT_PACKAGES += lights.MSM8974

# QC Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=/vendor/lib/libqc-opt.so

#common build.props
PRODUCT_PROPERTY_OVERRIDES += \
    ro.chipname=msm8974 \
    ro.sf.lcd_density=480 \
    ro.opengles.version=196608 \
    persist.timed.enable=true \
    keyguard.no_require_sim=true

# Radio properties
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libsec-ril.so \
    ril.subscription.types=NV,RUIM \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    ro.use_data_netmgrd=true \
    persist.data.netmgrd.qos.enable=true \
    persist.radio.add_power_save=1 \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.radio.lte_vrat_report=1 \
    persist.rild.nitz_plmn="" \
    persist.rild.nitz_long_ons_0="" \
    persist.rild.nitz_long_ons_1="" \
    persist.rild.nitz_long_ons_2="" \
    persist.rild.nitz_long_ons_3="" \
    persist.rild.nitz_short_ons_0="" \
    persist.rild.nitz_short_ons_1="" \
    persist.rild.nitz_short_ons_2="" \
    persist.rild.nitz_short_ons_3=""

# msm_rng entropy feeder
PRODUCT_PACKAGES += \
    qrngd \
    qrngp

# Wifi
PRODUCT_COPY_FILES += \
   device/samsung/hltedcm/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
   device/samsung/hltedcm/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

# Keymaster
PRODUCT_PACKAGES += \
    keystore.msm8974

# call common msm8974
$(call inherit-product, device/samsung/msm8974-common/msm8974.mk)

# call dalvik heap config
$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)

# call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

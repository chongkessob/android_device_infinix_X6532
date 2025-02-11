#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/infinix/X6532

# API
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Enable Virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# A/B
AB_OTA_UPDATER := true
ENABLE_VIRTUAL_AB := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    system_ext \
    product \
    vendor \
    vendor_boot \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true


# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service

# Google Deprecated this, as per statement from Google, this is not needed anymore
# PRODUCT_STATIC_BOOT_CONTROL_HAL was the workaround to allow sideloading with statically 
# linked boot control HAL, before shared library HALs were supported under recovery. 
# Android Q has added such support (HALs will be loaded in passthrough mode), 
# and the workarounds are being removed. Targets should build and install 
# the recovery variant of boot control HAL modules into recovery image, similar to the ones 
# installed for normal boot. 
# PRODUCT_STATIC_BOOT_CONTROL_HAL := \
#     bootctrl.mt6768 \
#     libgptutils \
#     libz \
#     libcutils

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# fastbootd
PRODUCT_PACKAGES += \
	android.hardware.fastboot@1.0-impl-mock \
	android.hardware.fastboot@1.0-impl-mock.recovery \
	fastbootd

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_USE_FSCRYPT_POLICY := 2
TW_FORCE_KEYMASTER_VER := true

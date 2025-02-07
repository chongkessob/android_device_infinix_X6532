#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/infinix/X6532

# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)


# Configure gsi_keys.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)


# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)


# API
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# frame rate
TW_FRAMERATE := 120

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_UPDATER := true
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

PRODUCT_PACKAGES += \
    bootctrl.mt6768 \
    libgptutils \
    libz \
    libcutils

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

# Recovery libs
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_USE_FSCRYPT_POLICY := 2
TW_FORCE_KEYMASTER_VER := true


# vendor_boot
ifeq ($(FOX_VENDOR_BOOT_RECOVERY),1)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)


# copy vendor_boot fstab to first_stage_ramdisk
PRODUCT_COPY_FILES += \
	$(DEVICE_PATH)/recovery/root/fstab-generic.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
	# $(DEVICE_PATH)/recovery/root/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
endif
# end: vendor_boot
#

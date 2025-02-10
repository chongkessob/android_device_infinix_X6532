#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/infinix/X6532

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from Infinix-X6532 device
$(call inherit-product, device/infinix/X6532/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := twrp_X6532
PRODUCT_DEVICE := X6532
PRODUCT_BRAND := Infinix
PRODUCT_MANUFACTURER := infinix
PRODUCT_MODEL := Infinix X6532

PRODUCT_GMS_CLIENTID_BASE := android-infinix

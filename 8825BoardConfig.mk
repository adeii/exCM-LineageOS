#
# Copyright 2014 The Android Open Source Project
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
PRODUCT_PREBUILT_WEBVIEWCHROMIUM=yes
ANDROID_COMPILE_WITH_JACK := false
DISABLE_DEXPREOPT=true

# Inherit from the proprietary version
-include vendor/huawei/u8825/BoardConfigVendor.mk

# Inherit from the u8833 definitions
-include device/huawei/u8833/BoardConfig.mk

TARGET_BOOTLOADER_BOARD_NAME := u8825

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 536870912 # 0x20000000

# Audio
TARGET_HAS_QACT := false

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/huawei/u8825/bluetooth

# Disable DEXPREOPT to allow space for GApps
WITH_DEXPREOPT := false

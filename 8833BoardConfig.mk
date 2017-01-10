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
WITH_DEXPREOPT=false
# Inherit from the proprietary version
-include vendor/huawei/u8833/BoardConfigVendor.mk

# Inherit from the common msm7x27a definitions
-include device/huawei/msm7x27a-common/BoardConfigCommon.mk

TARGET_BOOTLOADER_BOARD_NAME := u8833
TARGET_OTA_ASSERT_DEVICE := u8833,hwu8833,u8951,hwu8951

# Audio
TARGET_HAS_QACT := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/huawei/u8833/bluetooth

# Kernel
TARGET_KERNEL_CONFIG := u8833_defconfig

# Partitions
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824 # 0x40000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1207943168 # 0x47FFC000

# Recovery
BOARD_CUSTOM_GRAPHICS := ../../../device/huawei/u8833/recovery/graphics.c
TARGET_RECOVERY_FSTAB := device/huawei/u8833/rootdir/fstab.huawei

# Wi-Fi
BOARD_HAS_ATH_WLAN := true
BOARD_WLAN_DEVICE := ath6kl

BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)

WIFI_DRIVER_FW_PATH_AP := "ap"
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_P2P := "p2p"

WIFI_DRIVER_MODULE_NAME := "ar6000"
WIFI_DRIVER_MODULE_PATH := "/data/misc/wifi/load/ar6000.ko"
WIFI_DRIVER_IFACE_NAME := "eth"

WIFI_PARAMS += WIFI_FIX_HUAWEI_BUTCHERING="true"
WIFI_PARAMS += WIFI_POWER_TUNED="true"
WIFI_PARAMS += AR6005_SELF_INIT_SUPPORT="true"

WIFI_PARAMS += WIFI_DRIVER_IFACE_NAME="$(WIFI_DRIVER_IFACE_NAME)"
WIFI_PARAMS += WIFI_DRIVER_MODULE_PATH="$(WIFI_DRIVER_MODULE_PATH)"
WIFI_PARAMS += WIFI_DRIVER_MODULE_NAME="$(WIFI_DRIVER_MODULE_NAME)"

WIFI_PARAMS += AR6003_MAC_FILE="softmac"
WIFI_PARAMS += AR6003_REV2_BOARD_POWER_PA_FILE="../../data/misc/wifi/Cal_powerTuned_pa.bin"
WIFI_PARAMS += AR6003_HW_FW_DIR="ath6k"
WIFI_PARAMS += AR6003_HW_BOARD_DATA_FILE="load/caldata.bin"
WIFI_PARAMS += AR6003_HW_DEFAULT_BOARD_DATA_FILE="ath6k/bdata.SD31.bin"

# These currently have to go to the ramdisk for wlan_detect to pick them up.
# Hopefully they can join their friends at $(KERNEL_MODULES_OUT) soon. :(
KERNEL_EXTERNAL_MODULES:
	mkdir -p $(TARGET_ROOT_OUT)/wifi
	rm -rf $(TARGET_OUT_INTERMEDIATES)/ath6kl-huawei
	cp -a hardware/atheros/wifi/ath6kl-huawei $(TARGET_OUT_INTERMEDIATES)/
	$(MAKE) -C $(TARGET_OUT_INTERMEDIATES)/ath6kl-huawei/cfg80211 KERNEL_OUT=$(KERNEL_OUT) ARCH="arm" CROSS_COMPILE="arm-eabi-" modules
	$(MAKE) -C $(TARGET_OUT_INTERMEDIATES)/ath6kl-huawei/ar6000 KERNEL_OUT=$(KERNEL_OUT) ARCH="arm" CROSS_COMPILE="arm-eabi-" $(WIFI_PARAMS) modules
	$(TARGET_OBJCOPY) --strip-unneeded $(TARGET_OUT_INTERMEDIATES)/ath6kl-huawei/cfg80211/cfg80211.ko $(TARGET_ROOT_OUT)/wifi/cfg80211.ko
	$(TARGET_OBJCOPY) --strip-unneeded $(TARGET_OUT_INTERMEDIATES)/ath6kl-huawei/ar6000/ar6000.ko $(TARGET_ROOT_OUT)/wifi/ar6000.ko

TARGET_KERNEL_MODULES := KERNEL_EXTERNAL_MODULES

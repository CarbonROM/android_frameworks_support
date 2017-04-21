# Copyright (C) 2017 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

# Here is the final static library that apps can link against.
# Applications that use this library must specify
#
#   LOCAL_STATIC_ANDROID_LIBRARIES := \
#       android-support-emoji \
#       android-support-compat
#
# in their makefiles to include the resources and their dependencies in their package.
#
include $(CLEAR_VARS)
EXTERNAL_FONT_DIR := ../../../../external/noto-fonts/emoji-compat
LOCAL_USE_AAPT2 := true
LOCAL_MODULE := android-support-emoji
LOCAL_SDK_VERSION := $(SUPPORT_CURRENT_SDK_VERSION)
LOCAL_SRC_FILES := $(call all-java-files-under, src) \
    $(call all-java-files-under, $(EXTERNAL_FONT_DIR)/src/java)
LOCAL_STATIC_JAVA_LIBRARIES := \
    android-support-emoji-flatbuffers-jarjar
LOCAL_SHARED_ANDROID_LIBRARIES := \
    android-support-annotations \
    android-support-compat
LOCAL_JAR_EXCLUDE_FILES := none
LOCAL_JAVA_LANGUAGE_VERSION := 1.7
LOCAL_AAPT_FLAGS := --add-javadoc-annotation doconly
include $(BUILD_STATIC_JAVA_LIBRARY)

#############################################################
# Pre-built dependency jars
#############################################################

include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
    android-support-emoji-flatbuffers:$(EXTERNAL_FONT_DIR)/libs/flatbuffers-java-1.6.0.jar
include $(BUILD_MULTI_PREBUILT)

include $(CLEAR_VARS)
LOCAL_STATIC_JAVA_LIBRARIES := android-support-emoji-flatbuffers
LOCAL_JARJAR_RULES := $(LOCAL_PATH)/jarjar-rules.txt
LOCAL_MODULE := android-support-emoji-flatbuffers-jarjar
include $(BUILD_STATIC_JAVA_LIBRARY)
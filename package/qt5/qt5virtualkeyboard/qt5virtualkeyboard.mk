################################################################################
#
# qt5virtualkeyboard
#
################################################################################

QT5VIRTUALKEYBOARD_VERSION = $(QT5_VERSION)
QT5VIRTUALKEYBOARD_SITE = $(QT5_SITE)
QT5VIRTUALKEYBOARD_SOURCE = qtvirtualkeyboard-opensource-src-$(QT5VIRTUALKEYBOARD_VERSION).tar.xz
QT5VIRTUALKEYBOARD_DEPENDENCIES = qt5base qt5declarative qt5svg
QT5VIRTUALKEYBOARD_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_QT5BASE_LICENSE_APPROVED),y)
QT5VIRTUALKEYBOARD_LICENSE = GPLv3
QT5VIRTUALKEYBOARD_LICENSE_FILES = LICENSE.GPL3
else
QT5VIRTUALKEYBOARD_LICENSE = Commercial license
QT5VIRTUALKEYBOARD_REDISTRIBUTE = NO
endif

LANGUAGE_LAYOUTS = $(call qstrip,$(BR2_PACKAGE_QT5VIRTUALKEYBOARD_LANGUAGE_LAYOUTS))
ALL = $(findstring all,$(LANGUAGE_LAYOUTS))
ifneq ($(strip $(LANGUAGE_LAYOUTS)),)
QMAKEFLAGS += CONFIG+="$(foreach lang,$(LANGUAGE_LAYOUTS),lang-$(lang))"

OPENWNN = $(findstring ja_JP,$(LANGUAGE_LAYOUTS))
ifneq ($(strip $(OPENWNN)$(ALL)),)
QT5VIRTUALKEYBOARD_LICENSE += Apache-2.0
QT5VIRTUALKEYBOARD_LICENSE_FILES += src/virtualkeyboard/3rdparty/openwnn/NOTICE
endif

PINYIN = $(findstring zh_CN,$(LANGUAGE_LAYOUTS))
ifneq ($(strip $(PINYIN)$(ALL)),)
THIRD_PARTS += pinyin
QT5VIRTUALKEYBOARD_LICENSE += Apache-2.0
QT5VIRTUALKEYBOARD_LICENSE_FILES += src/virtualkeyboard/3rdparty/pinyin/NOTICE
endif

TCIME = $(findstring zh_TW,$(LANGUAGE_LAYOUTS))
ifneq ($(strip $(TCIME)$(ALL)),)
THIRD_PARTS += tcime
QT5VIRTUALKEYBOARD_LICENSE += Apache-2.0 BSD-3c
QT5VIRTUALKEYBOARD_LICENSE_FILES += src/virtualkeyboard/3rdparty/tcime/COPYING
endif
endif

ifeq ($(BR2_PACKAGE_QT5VIRTUALKEYBOARD_HANDWRITING),y)
THIRD_PARTS += lipi_toolkit
QMAKEFLAGS += CONFIG+=handwriting
QT5VIRTUALKEYBOARD_LICENSE += MIT
QT5VIRTUALKEYBOARD_LICENSE_FILES += src/virtualkeyboard/3rdparty/lipi-toolkit/MIT_LICENSE.txt
endif

ifeq ($(BR2_PACKAGE_QT5VIRTUALKEYBOARD_HUNSPELL),y)
QMAKEFLAGS += CONFIG+=hunspell
else
ifeq ($(BR2_PACKAGE_HUNSPELL),y)
QMAKEFLAGS += CONFIG+=disable-hunspell
endif
endif

ifeq ($(BR2_PACKAGE_QT5VIRTUALKEYBOARD_RETRO_STYLE),y)
QMAKEFLAGS += CONFIG+=retro-style
endif

ifeq ($(BR2_PACKAGE_QT5VIRTUALKEYBOARD_ARROW_KEY_NAVIGATION),y)
QMAKEFLAGS += CONFIG+=arrow-key-navigation
endif

ifneq ($(strip $(THIRD_PARTS)),)
define QT5VIRTUALKEYBOARD_INSTALL_TARGET_THIRD_PARTS
	cp -dpfr $(STAGING_DIR)/usr/qtvirtualkeyboard $(TARGET_DIR)/usr
endef
endif

define QT5VIRTUALKEYBOARD_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/qmake $(QMAKEFLAGS))
endef

define QT5VIRTUALKEYBOARD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5VIRTUALKEYBOARD_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
define QT5VIRTUALKEYBOARD_INSTALL_TARGET_EXAMPLES
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/examples/virtualkeyboard $(TARGET_DIR)/usr/lib/qt/examples/
endef
endif

define QT5VIRTUALKEYBOARD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/qt/plugins/platforminputcontexts
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/plugins/platforminputcontexts/libqtvirtualkeyboardplugin.so $(TARGET_DIR)/usr/lib/qt/plugins/platforminputcontexts
	cp -dpfr $(STAGING_DIR)/usr/qml/QtQuick/VirtualKeyboard $(TARGET_DIR)/usr/qml/QtQuick
	$(QT5VIRTUALKEYBOARD_INSTALL_TARGET_THIRD_PARTS)
	$(QT5VIRTUALKEYBOARD_INSTALL_TARGET_EXAMPLES)
endef

$(eval $(generic-package))

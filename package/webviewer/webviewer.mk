################################################################################
#
# webviewer
#
################################################################################

WEBVIEWER_VERSION = hackathon-20170204
WEBVIEWER_SITE = $(call github,gazoo74,webviewer,hackathon-20170204)

WEBVIEWER_LICENSE = MIT
WEBVIEWER_LICENSE_FILES = LICENSE

define WEBVIEWER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define WEBVIEWER_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		DESTDIR=$(TARGET_DIR) PREFIX=/usr/bin install
endef

$(eval $(generic-package))

################################################################################
#
# webviewer
#
################################################################################

WEBVIEWER_VERSION = 1
WEBVIEWER_SITE = /home/gportay/src/webviewer
WEBVIEWER_SITE_METHOD = local

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

################################################################################
#
# hunspell
#
################################################################################

HUNSPELL_VERSION = 1.6.0
HUNSPELL_SITE = $(call github,hunspell,hunspell,v$(HUNSPELL_VERSION))
HUNSPELL_AUTORECONF = YES
HUNSPELL_INSTALL_STAGING = YES

HUNSPELL_LICENSE = GPLv3 LGPLv3 MPL
HUNSPELL_LICENSE_FILES = COPYING COPYING.LESSER  COPYING.MPL

$(eval $(autotools-package))

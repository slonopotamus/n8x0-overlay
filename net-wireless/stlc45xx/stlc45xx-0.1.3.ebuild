# Copyright 2009 Luke Dashjr
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit linux-mod

DESCRIPTION="a mac80211 driver for stlc4550 and stlc4560 WLAN chips used, for example, in Nokia N800 and N810"
HOMEPAGE="http://stlc45xx.garage.maemo.org/"
LICENSE="GPL-2"

SRC_URI="https://garage.maemo.org/frs/download.php/4582/${P}.tar.gz"
SLOT="0"
KEYWORDS='~arm'
IUSE=''

DEPEND='
	virtual/linux-sources
'
RDEPEND='
'

BUILD_PARAMS="KERNEL_SRC_DIR=${KERNEL_DIR}"
BUILD_TARGETS="clean modules"
MODULE_NAMES="${PN}(kernel/drivers/net/wireless:${S}:${S}/src)"

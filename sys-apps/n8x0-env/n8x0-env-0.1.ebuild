# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

IUSE="bluetooth wifi X"
LICENSE="GPL-2"
DESCRIPTION="Meta-package bringing minimal needed software to operate on Nokia N8x0 tablets"
HOMEPAGE="http://slonopotamus.org/gentoo-on-n8x0"
SLOT="0"
KEYWORDS="~arm"
RDEPEND="sys-apps/nit-bootmenu-compat
	sys-kernel/diablo-sources
	bluetooth? (
		net-wireless/nokia-n8x0-firmware
		net-wireless/bluez-utils
	)
	wifi? (
		net-wireless/tablet-wireless
		net-wireless/wireless-tools
		net-wireless/wpa_supplicant
	)
	X? (
		x11-misc/nokia-tablets-pointercal
		x11-drivers/xf86-input-tslib
		x11-drivers/xf86-video-omapfb
	)"

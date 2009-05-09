# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

IUSE="bluetooth gps wifi X keyboard"
LICENSE="GPL-2"
DESCRIPTION="Meta-package bringing minimal needed software to operate on Nokia N8x0 tablets"
HOMEPAGE="http://slonopotamus.org/gentoo-on-n8x0"
SLOT="0"
KEYWORDS="~arm"
RDEPEND="sys-apps/nit-bootmenu-compat
	sys-kernel/diablo-sources
	bluetooth? (
		net-wireless/nokia-n8x0-firmware[bluetooth]
		net-wireless/bluez-utils
	)
	gps? (
		sci-geosciences/gps5300driver
	)
	wifi? (
		net-wireless/cx3110x
		net-wireless/wireless-tools
	)
	keyboard? ( sys-apps/kbd[512keys] )
	X? (
		x11-misc/nokia-tablets-pointercal
		x11-base/xorg-server[tslib,xorg,input_devices_evdev,input_devices_tslib]
		|| (
			x11-base/xorg-server[video_cards_fbdev]
			x11-drivers/xf86-video-omapfb
		)
	)"

pkg_postinst() {
	ewarn "If you're updating from <0.3 version of ${PN}, consider"
	ewarn "updating your 'Device' section in /etc/X11/xorg.conf because"
	ewarn "we found xf86-video-fbdev is better than xf86-video-omapfb"
	echo
	ewarn 'Section "Device"'
	ewarn '  Identifier      "device"'
	ewarn '  Driver          "fbdev"'
	ewarn 'EndSection'
}

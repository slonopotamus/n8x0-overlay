# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

IUSE="alsa bluetooth cx3110x gps nokia-osso-linux stlc45xx wifi +wifi-calibrate X keyboard"
LICENSE="GPL-2"
DESCRIPTION="Meta-package bringing minimal needed software to operate on Nokia N8x0 tablets"
HOMEPAGE="http://slonopotamus.org/gentoo-on-n8x0"
SLOT="0"
KEYWORDS="~arm"
RDEPEND="
	sys-apps/nit-bootmenu-compat

	nokia-osso-linux? (
		sys-kernel/diablo-sources
	)
	bluetooth? (
		net-wireless/nokia-n8x0-firmware[bluetooth]
		|| (
			net-wireless/bluez
			net-wireless/bluez-utils
		)
	)
	gps? (
		sci-geosciences/gps5300driver
	)
	wifi? (
		|| (
			net-wireless/nokia-n8x0-firmware[wifi]
			net-wireless/stlc4550-firmware
		)
		net-wireless/wireless-tools
		!stlc45xx? (
			net-wireless/cx3110x
		)
		cx3110x? (
			net-wireless/cx3110x
		)
		nokia-osso-linux? (
			net-wireless/cx3110x
		)
		stlc45xx? (
			wifi-calibrate? (
				net-wireless/stlc45xx-cal
			)
		)
	)
	keyboard? ( sys-apps/kbd[512keys] )
	alsa? (
		nokia-osso-linux? (
			media-sound/tablet-sound
		)
	)
	X? (
		x11-misc/nokia-tablets-pointercal
		x11-base/xorg-server[tslib,xorg]
		|| (
			x11-base/xorg-server[input_devices_evdev,input_devices_tslib]
			x11-base/xorg-drivers[input_devices_evdev,input_devices_tslib]
		)
		|| (
			x11-base/xorg-server[video_cards_fbdev]
			x11-base/xorg-drivers[video_cards_fbdev]
			x11-drivers/xf86-video-omapfb
		)
	)
"

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

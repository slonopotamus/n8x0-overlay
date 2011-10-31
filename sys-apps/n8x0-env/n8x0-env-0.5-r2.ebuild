# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=4

IUSE="alsa bluetooth cx3110x gps internalgps nokia-osso-linux stlc45xx wifi +wifi-calibrate X keyboard"
REQUIRED_USE="
	gps? ( || ( internalgps bluetooth ) )
"
LICENSE="GPL-2"
DESCRIPTION="Meta-package bringing minimal needed software to operate on Nokia N8x0 tablets"
HOMEPAGE="http://slonopotamus.org/gentoo-on-n8x0"
SLOT="0"
KEYWORDS="arm"
RDEPEND="
	sys-apps/nit-bootmenu-compat
	internalgps? ( sci-geosciences/gps5300driver )
	keyboard? ( sys-apps/kbd[512keys] )

	nokia-osso-linux? (
		sys-kernel/diablo-sources

		alsa? ( media-sound/tablet-sound )
	)

	bluetooth? (
		net-wireless/nokia-n8x0-firmware[bluetooth]
		|| (
			net-wireless/bluez
			net-wireless/bluez-utils
		)
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

	X? (
		x11-misc/nokia-tablets-pointercal
		x11-base/xorg-server[tslib,xorg]
		|| (
			x11-base/xorg-drivers[input_devices_evdev,input_devices_tslib]
			x11-base/xorg-server[input_devices_evdev,input_devices_tslib]
		)

		|| (
			x11-base/xorg-drivers[video_cards_omapfb]
			x11-base/xorg-drivers[video_cards_fbdev]
			x11-base/xorg-server[video_cards_fbdev]
			x11-drivers/xf86-video-omapfb
		)
	)
"

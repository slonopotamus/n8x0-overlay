# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

inherit eutils

SRC_URI="
	http://github.com/downloads/slonopotamus/n8x0-overlay/${P}.tar.gz
	http://slonopotamus.org/_media/gentoo-on-n8x0/${P}.tar.gz
"
KEYWORDS="arm"
SLOT="0"
LICENSE="BSD"
DESCRIPTION="Metapackage that provides sound support on Nokia Internet Tablets"
HOMEPAGE="http://wiki.maemo.org/Mer"
IUSE="+udev gstreamer"
RDEPEND="
	media-sound/alsa-utils
	media-plugins/alsa-plugins[nokia-osso-linux]
	media-sound/osso-dsp-loader
	gstreamer? ( media-plugins/gst-plugins-dsp )
	udev? ( sys-fs/udev )
"

# mermen can't properly package tarballs for some reason...
S="${WORKDIR}/${PN}-2.4"

src_install() {
	if use udev; then
		insinto "/etc/udev/rules.d"
		doins "51-sound.rules"
	fi

	insinto "/etc"
	doins "asound.conf"
}

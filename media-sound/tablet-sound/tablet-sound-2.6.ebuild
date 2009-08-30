# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

inherit eutils

SRC_URI="http://slonopotamus.org/_media/gentoo-on-n8x0/${P}.tar.gz"
KEYWORDS="~arm"
SLOT="0"
LICENSE="BSD"
DESCRIPTION="Metapackage that provides sound support on Nokia Internet Tablets"
HOMEPAGE="http://wiki.maemo.org/Mer"
IUSE=""
RDEPEND="
	media-sound/alsa-utils
	media-plugins/alsa-plugins[maemo]
	media-sound/osso-dsp-loader
"

# mermen can't properly package tarballs for some reason...
S="${WORKDIR}/${PN}-2.4"

src_install() {
	insinto "/etc/udev/rules.d"
	doins "51-sound.rules"

	insinto "/etc"
	doins "asound.conf"

	insinto "/var/lib/alsa/"
	doins "asound.state"
}

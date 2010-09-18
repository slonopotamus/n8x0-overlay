# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

inherit autotools

MY_PN="${PN}0.10"
MY_PV="${PV}~diablo2"

SLOT="0"
SRC_URI="http://repository.maemo.org/pool/diablo/free/g/${MY_PN}/${MY_PN}_${MY_PV}.tar.gz"
DESCRIPTION="GStreamer plugin to output sound to OMAP DSP"
LICENSE="GPL-2"
KEYWORDS="~arm"
IUSE=""

DEPEND="
	sys-apps/dbus
	media-sound/osso-dsp-headers
	>=media-libs/gstreamer-0.10.25
	>=media-libs/gst-plugins-base-0.10.25"
RDEPEND="${DEPEND} media-sound/osso-dsp-loader"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}/disable-werror.patch"
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}"
}

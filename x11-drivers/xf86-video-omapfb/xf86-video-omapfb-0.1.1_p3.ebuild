# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

MY_PN='xserver-xorg-video-omapfb'
MY_PV="${PV/_p/-}"
MY_PFN="${PN}_${MY_PV}.tar.gz"
SRC_URI="mirror://debian/pool/main/x/${PN}/${MY_PFN}"
DESCRIPTION="X.Org driver for TI OMAP framebuffers"
KEYWORDS="arm"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/renderproto"
S="${WORKDIR}/${P/_p*/}"
IUSE="neon"
LICENSE="as-is"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable neon)"
}

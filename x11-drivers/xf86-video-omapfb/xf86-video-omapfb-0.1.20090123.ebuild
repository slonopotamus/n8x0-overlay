# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

MY_PN='xserver-xorg-video-omapfb'
MY_PV="${PV}-1-mer2"
SRC_URI="
	http://repository.mer.tspre.org/pool/main/x/${MY_PN}/${MY_PN}_${MY_PV}.tar.gz
"
DESCRIPTION="OMAP framebuffer video driver"
KEYWORDS="~arm"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/renderproto"
PATCHES=( "${FILESDIR}/no-uint8_t-fix.patch" )
S="${WORKDIR}/${MY_PN}"
IUSE=""
LICENSE="as-is"

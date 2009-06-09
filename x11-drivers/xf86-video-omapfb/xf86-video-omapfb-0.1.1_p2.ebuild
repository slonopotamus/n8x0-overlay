# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

MY_PN='xserver-xorg-video-omapfb'
MY_PV="${PV/_p/-}"
MY_PFN="${PN}_${MY_PV}.tar.gz"
SRC_URI="
	mirror://debian/pool/main/x/${PN}/${MY_PFN}
	mirror://ubuntu/pool/universe/x/${PN}/${MY_PFN}
	http://luke.dashjr.org/programs/gentoo-n8x0/distfiles/${MY_PFN}
"
DESCRIPTION="OMAP framebuffer video driver"
KEYWORDS="~arm"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/renderproto"
S="${WORKDIR}/${MY_PN}"
IUSE=""
LICENSE="as-is"

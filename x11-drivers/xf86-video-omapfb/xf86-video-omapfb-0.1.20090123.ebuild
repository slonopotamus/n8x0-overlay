# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

SRC_URI="http://repository.mer.tspre.org/pool/main/x/xserver-xorg-video-omapfb/xserver-xorg-video-omapfb_0.1.20090123-1-mer2.tar.gz"
DESCRIPTION="OMAP framebuffer video driver"
KEYWORDS="~arm"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/renderproto"
PATCHES=( "${FILESDIR}/no-uint8_t-fix.patch" )
S="${WORKDIR}/xserver-xorg-video-omapfb"
IUSE=""
LICENSE="as-is"

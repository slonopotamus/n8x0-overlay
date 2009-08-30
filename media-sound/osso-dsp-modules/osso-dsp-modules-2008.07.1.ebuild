# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

SRC_URI="mirror://n8x0/updates/diablo/${PN}-rx-44_${PV}_all.deb"
KEYWORDS="-* ~arm"
SLOT="0"
LICENSE="CopyrightNokia"
DESCRIPTION="DSP modules for OSSO Multimedia framework"
HOMEPAGE="http://nokia.com/"
IUSE=""
RESTRICT="mirror installsources bindist"
RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_unpack() {
        unpack ${A}
        unpack ./data.tar.gz
}

src_install() {
	doins -r lib || die
}

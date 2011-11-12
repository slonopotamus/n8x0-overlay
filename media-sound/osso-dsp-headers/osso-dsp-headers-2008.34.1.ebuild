# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

uPN="${PN}-rx-44"
SRC_URI="http://repository.maemo.org/pool/diablo/non-free/o/osso-dsp-modules-rx-44/${uPN}_${PV}_all.deb"
KEYWORDS="arm"
SLOT="0"
LICENSE="as-is"
DESCRIPTION="DSP headers for OSSO Multimedia framework"
HOMEPAGE="http://nokia.com/"
IUSE=""
RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
}

src_install() {
	insinto usr
	doins -r usr/include || die
	cd "usr/share/doc/${uPN}" || die
	dodoc copyright
	dodoc changelog.gz
}

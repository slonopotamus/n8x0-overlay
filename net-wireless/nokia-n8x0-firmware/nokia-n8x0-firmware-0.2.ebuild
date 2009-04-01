# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils

SRC_URI="http://repository.mer.tspre.org/pool/main/n/${PN}/${PN}_${PV}.tar.gz"
DESCRIPTION="Way to bring Nokia N8x0 wifi & bluetooth chip firmware"
KEYWORDS="~arm"
SLOT="0"
LICENSE="BSD"
HOMEPAGE="http://wiki.maemo.org/Mer"
IUSE=""

S="${WORKDIR}/${PN}"

src_install() {
	dodir /lib/firmware/
	while read line; do ln -s ${line/ \// ${D}\/}; done < <(cat debian/links) || die
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils

SRC_URI="http://repository.mer.tspre.org/pool/main/n/${PN}/${PN}_${PV}.tar.gz"
DESCRIPTION="TODO"
KEYWORDS="~arm"
SLOT="0"
IUSE=""
LICENSE="MIT"
HOMEPAGE="http://wiki.maemo.org/Mer"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/gentoofy.patch"
}

src_install() {
	insinto /etc
	doins pointercal-*
	newinitd debian/${PN}.init ${PN}
}

pkg_postinst() {
	einfo "Please add '${PN}' init script to boot services"
	einfo "by running: rc-update add ${PN} default"
}

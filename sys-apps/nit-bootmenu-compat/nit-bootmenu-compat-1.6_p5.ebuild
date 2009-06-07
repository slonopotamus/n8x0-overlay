# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils

SRC_URI="http://repository.mer.tspre.org/pool/main/n/${PN}/${PN}_${PV/_p/mer}.tar.gz"
KEYWORDS="~arm"
SLOT="0"
LICENSE="BSD"
HOMEPAGE="http://wiki.maemo.org/Mer"
IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/gentoofy.patch"
	epatch "${FILESDIR}/nokia_tmp.patch"
}

src_install() {
	doins linuxrc
	dodir /mnt/initfs
	dodir /var/run/nokia/
	doinitd etc/init.d/nit-boot-basics
}

pkg_postinst() {
	einfo "Please add 'nit-boot-basics' init script to boot services"
	einfo "by running: rc-update add nit-boot-basics boot"
}

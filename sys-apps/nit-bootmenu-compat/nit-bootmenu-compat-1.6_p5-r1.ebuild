# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils

SRC_URI="
	http://repository.mer.tspre.org/pool/main/n/${PN}/${PN}_${PV/_p/mer}.tar.gz
	http://luke.dashjr.org/programs/gentoo-n8x0/distfiles/${PN}_${PV/_p/mer}.tar.gz
"
KEYWORDS="~arm"
SLOT="0"
LICENSE="BSD"
HOMEPAGE="http://wiki.maemo.org/Mer"
IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	
	cd "${S}"
	epatch "${FILESDIR}/gentoofy.patch"
	epatch "${FILESDIR}/var_nokia.patch"
}

src_install() {
	doins linuxrc
	dodir /var/run/nokia/
	doinitd etc/init.d/nit-boot-basics
}

pkg_postinst() {
	einfo "Please add 'nit-boot-basics' init script to boot services"
	einfo "by running: rc-update add nit-boot-basics boot"

	# Can't install a .keep here, since it's read-only
	mkdir --mode=000 -p /mnt/initfs
}

pkg_postrm() {
	ewarn "/mnt/initfs has NOT been removed"
}

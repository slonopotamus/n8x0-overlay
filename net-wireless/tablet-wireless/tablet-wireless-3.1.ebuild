# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=1

inherit eutils

KEYWORDS="~arm"
SLOT="0"
LICENSE="BSD"
HOMEPAGE="http://slonopotamus.org/gentoo-on-n8x0"
IUSE="cx3110x stlc45xx"
RDEPEND="
	!stlc45xx? (
		net-wireless/cx3110x
	)
	cx3110x? (
		net-wireless/cx3110x
	)
	stlc45xx? (
		net-wireless/stlc45xx-cal
	)
"

src_install() {
	newinitd "${FILESDIR}/${PN}.init" "${PN}"
}

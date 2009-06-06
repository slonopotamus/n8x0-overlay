# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=1

inherit eutils

KEYWORDS="~arm"
SLOT="0"
LICENSE="BSD"
HOMEPAGE="http://slonopotamus.org/gentoo-on-n8x0"
IUSE="stlc45xx +wifi-calibrate"
RDEPEND="
	!stlc45xx? (
	net-wireless/cx3110x
	)
	stlc45xx? (
		wifi-calibrate? (
			net-wireless/stlc45xx-cal
		)
	)
"

S="${WORKDIR}"
src_compile() {
	local remove
	if use stlc45xx; then
		remove="IF:cx3110x"
	else
		remove="IF:stlc45xx"
	fi
	use wifi-calibrate ||
		remove="${remove}\\|IF:cal"
	grep -v "$remove" "${FILESDIR}/${PN}.init" \
		> "${S}/${PN}"
}

src_install() {
	doinitd "${S}/${PN}"
}

pkg_postinst() {
	einfo "Please add '${PN}' init script to boot services"
	einfo "by running: rc-update add ${PN} boot"
}

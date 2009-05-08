# Copyright 2009 Luke Dashjr <luke_n8x0_stlc4560-firmware@dashjr.org>
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

DESCRIPTION="binary firmware for stlc4560 wifi chip"
HOMEPAGE=""
LICENSE="Copyright"

SRC_URI="http://daemonizer.de/prism54/prism54-fw/${PN/-firmware/}/${PV/9910/a}.arm"
SLOT="0"
KEYWORDS="~arm"
IUSE=""
RESTRICT="mirror installsources bindist"

DEPEND=''
RDEPEND="${DEPEND}"'
	!net-wireless/nokia-n8x0-firmware[wifi,n810]
	!net-wireless/nokia-n8x0-firmware[wifi,-n800]
'

S="${WORKDIR}"

src_install() {
	insinto /lib/firmware/
	newins "${DISTDIR}/${A}" 3826.arm
}

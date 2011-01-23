# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://nopcode.org/${PN}/get/${P}.tar.gz"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-3"
HOMEPAGE="http://nopcode.org/${PN}"
DESCRIPTION="Free flasher for the Nokia internet tablets"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

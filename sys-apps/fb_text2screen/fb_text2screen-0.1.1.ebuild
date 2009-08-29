# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit cmake-utils linux-info

SRC_URI="http://slonopotamus.org/_media/gentoo-on-n8x0/${P}.tar.gz"
KEYWORDS="~arm"
SLOT="0"
LICENSE="GPL-3"
HOMEPAGE="http://slonopotamus.org/gentoo-on-n8x0#${PN}"
IUSE=""
RDEPEND=">=dev-libs/popt-1.10"
DEPEND="${RDEPEND}"

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit cmake-utils

SRC_URI="http://slonopotamus.org/_media/gentoo-on-n8x0/${P}.tar.gz"
KEYWORDS="~arm"
SLOT="0"
LICENSE="GPL-3"
HOMEPAGE="http://github.com/slonopotamus/opendsme"
IUSE=""
RDEPEND=">=dev-libs/popt-1.10"
DEPEND="${RDEPEND}"

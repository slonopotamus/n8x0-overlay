# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=3

inherit cmake-utils linux-info

SRC_URI="https://github.com/slonopotamus/${PN}/tarball/v${PV} -> ${P}.tar.gz"
KEYWORDS="~arm"
SLOT="0"
LICENSE="GPL-3"
HOMEPAGE="http://github.com/slonopotamus/${PN}"
IUSE=""
RDEPEND=">=dev-libs/popt-1.10"
DEPEND="${RDEPEND}"

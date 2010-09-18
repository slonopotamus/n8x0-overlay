# Copyright 2008-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/tslib/tslib-1.0-r1.ebuild,v 1.9 2009/04/21 09:19:33 armin76 Exp $

ESVN_REPO_URI="svn://svn.berlios.de/tslib/trunk/tslib"
ESVN_BOOTSTRAP="autogen.sh"

inherit subversion eutils toolchain-funcs autotools

DESCRIPTION="Touchscreen Access Library"
KEYWORDS="~arm"
IUSE=""
#extras arctic2 collie corgi h3600 linear-h2200 mk712 ucb1x00"
DEPEND=""
RDEPEND=""
HOMEPAGE="http://tslib.berlios.de/"
SRC_URI=""
SLOT="0"
LICENSE="LGPL-2"

src_compile() {
	# compile everything. INSTALL_MASK= what you don't want.
	econf	--enable-linear --enable-dejitter \
		--enable-variance --enable-pthres \
		--enable-input --enable-shared \
		--enable-arctic2 --enable-collie \
		--enable-corgi 	--enable-h3600 \
		--enable-linear-h2200 --enable-mk712 \
		--enable-ucb1x00 --disable-debug || die "Configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README
}

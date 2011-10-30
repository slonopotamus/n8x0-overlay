# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.6.38-r7.ebuild,v 1.2 2011/08/11 17:19:46 mpagano Exp $

EAPI="2"
ETYPE="sources"
K_DEBLOB_AVAILABLE="0"
IUSE=""

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~arm"
HOMEPAGE="http://github.com/slonopotamus/n8x0-overlay"
SRC_URI="${KERNEL_URI}"

src_prepare() {
	EPATCH_SOURCE="${FILESDIR}/${PV}/openwrt-patches" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
	[ -d "${FILESDIR}/${PV}/gentoo-patches" ] && EPATCH_SOURCE="${FILESDIR}/${PV}/gentoo-patches" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
}

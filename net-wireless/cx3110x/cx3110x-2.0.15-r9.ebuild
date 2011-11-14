# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

inherit linux-mod

MY_PN="${PN}-module-src"
WPA_PATCH="deblet-${PN}.patch"
DESCRIPTION="${PN} wifi driver"
SRC_URI="
	http://repository.maemo.org/pool/maemo4.1/free/c/${MY_PN}/${MY_PN}_${PV}-1.tar.gz
	http://repository.maemo.org/pool/diablo/free/c/${MY_PN}/${MY_PN}_${PV}-1.tar.gz
	http://luke.dashjr.org/programs/gentoo-n8x0/distfiles/${MY_PN}_${PV}-1.tar.gz

	we-18? (
		http://trac.tspre.org/svn/deblet/!svn/bc/457/trunk/packages/main/${MY_PN}/patches/${WPA_PATCH}
		http://luke.dashjr.org/programs/gentoo-n8x0/distfiles/${WPA_PATCH}
	)
"
LICENSE="GPL-2"
HOMEPAGE="http://www.maemo.org"

SLOT="0"
KEYWORDS="arm"
IUSE="debug +udev +we-18"

DEPEND="sys-kernel/diablo-sources"
RDEPEND="net-wireless/nokia-n8x0-firmware[wifi]"

S="${WORKDIR}/${MY_PN}-${PV}/src"

BUILD_TARGETS="clean modules"
BUILD_PARAMS="KERNEL_SRC_DIR=${KERNEL_DIR}"
if use debug; then
	MODULE_NAMES="${PN}_mt(kernel/drivers/net/wireless)"
	BUILD_PARAMS="${BUILD_PARAMS} CONFIG_CX3110X_PROD=m"
else
	MODULE_NAMES="${PN}(kernel/drivers/net/wireless)"
	BUILD_PARAMS="${BUILD_PARAMS} CONFIG_CX3110X_STA=m"
fi

src_prepare() {
	epatch "${FILESDIR}/no-config.h-fix.patch"
	epatch "${FILESDIR}/notfix.patch"
	use we-18 && epatch "${DISTDIR}/${WPA_PATCH}"
	epatch "${FILESDIR}/qemu-make-pwd-fix.patch"
}

src_install() {
	linux-mod_src_install

	local blobmod=umac
	use debug && blobmod=mtum
	dosym "/mnt/initfs/lib/modules/${KV_FULL}/${blobmod}.ko" "/lib/modules/${KV_FULL}/kernel/drivers/net/wireless/${blobmod}.ko"

	if use udev; then
		exeinto "/$(get_libdir)/udev"
		doexe "${FILESDIR}/${PN}-cal" \
			|| die "${PN}-cal script not installed properly"
		insinto "/etc/udev/rules.d"
		newins "${FILESDIR}/${PN}.rules" "40-${PN}.rules" \
			|| die "${PN} udev rules not installed properly"
	fi
}
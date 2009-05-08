# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit linux-mod

MY_PN="${PN}-module-src"
DESCRIPTION="${PN} wifi driver"
SRC_URI="http://repository.mer.tspre.org/pool/main/c/${MY_PN}/${MY_PN}_${PV}-1.tar.gz"
LICENSE="GPL-2"
HOMEPAGE="http://www.maemo.org"

SLOT="0"
KEYWORDS="~arm"
IUSE="debug"

DEPEND="virtual/linux-sources"
RDEPEND="
	|| (
		net-wireless/nokia-n8x0-firmware[wifi]
		net-wireless/stlc4550-firmware
		net-wireless/stlc4560-firmware
	)
	!=net-wireless/stlc4560-firmware-2.13.0.0.9910.13.14
	!=net-wireless/stlc4560-firmware-2.13.0.0.9910.22.0
	!=net-wireless/stlc4560-firmware-2.13.0.0.9910.23
	!=net-wireless/stlc4560-firmware-2.13.12.0.9910.5.2
"

S="${WORKDIR}/${MY_PN}/src"

BUILD_TARGETS="clean modules"
BUILD_PARAMS="KERNEL_SRC_DIR=${KERNEL_DIR}"
if use debug; then
	MODULE_NAMES="${PN}_mt(kernel/drivers/net/wireless)"
	BUILD_PARAMS="${BUILD_PARAMS} CONFIG_CX3110X_PROD=m"
else
	MODULE_NAMES="${PN}(kernel/drivers/net/wireless)"
	BUILD_PARAMS="${BUILD_PARAMS} CONFIG_CX3110X_STA=m"
fi

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/no-config.h-fix.patch"
}

src_install() {
	linux-mod_src_install
	
	local blobmod=umac
	use debug && blobmod=mtum
	dosym "/mnt/initfs/lib/modules/${KV_FULL}/${blobmod}.ko" "/lib/modules/${KV_FULL}/kernel/drivers/net/wireless/${blobmod}.ko"
	
	exeinto "/$(get_libdir)/udev"
	doexe "${FILESDIR}/${PN}-cal" ||
		die "${PN}-cal script not installed properly"
	insinto "/etc/udev/rules.d"
	newins "${FILESDIR}/${PN}.rules" "40-${PN}.rules" ||
		die "${PN} udev rules not installed properly"
}

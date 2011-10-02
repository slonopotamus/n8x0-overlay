# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

inherit linux-mod

MY_PN="${PN}-module-src"
WPA_PATCH="deblet-${PN}.patch"
DESCRIPTION="${PN} wifi driver"
SRC_URI="
	http://github.com/downloads/slonopotamus/n8x0-overlay/${MY_PN}_${PV}-1.tar.gz

	we-18? ( http://github.com/downloads/slonopotamus/n8x0-overlay/${WPA_PATCH} )
"
LICENSE="GPL-2"
HOMEPAGE="http://www.maemo.org"

SLOT="0"
KEYWORDS="arm"
IUSE="debug +udev +we-18"

DEPEND="virtual/linux-sources"
RDEPEND="
	udev? ( sys-fs/udev )
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

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils

SRC_URI=""
DESCRIPTION="symlinks to binary Nokia N8x0 wifi, bluetooth, and WiMax firmwares"
KEYWORDS="arm"
SLOT="0"
LICENSE="GPL-2"
HOMEPAGE="http://slonopotamus.org/gentoo-on-n8x0"
IUSE="bluetooth wifi wimax"

RDEPEND="
	wifi? (
		!net-wireless/stlc4560-firmware
	)
"

src_install() {
	local ffl= ff
	if use bluetooth; then
		ffl="$ffl bc4fw.bin"
	fi
	if use wifi; then
		ffl="$ffl 3826.arm"
	fi
	if use wimax; then
		ffl="$ffl omap2420_pa.bin omap2420_pafmt.bin omap2420_papub.bin omap2420_wrap.bin"
	fi
	for ff in $ffl; do
		dosym /mnt/initfs/usr/lib/hotplug/firmware/$ff /lib/firmware/$ff \
		  || die "Error making link to $ff"
	done
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

DESCRIPTION="binary driver for GPS5300 gps chip"
HOMEPAGE="http://nokia.com"
LICENSE="CopyrightNokia"
MyPN="${PN/5300/}"

SRC_URI="mirror://n8x0/updates/diablo/${MyPN}_${PV}_armel.deb"
SLOT="0"
KEYWORDS="-* ~arm"
IUSE="gconf"
RESTRICT="mirror"

DEPEND=''
RDEPEND="${DEPEND}"'
	>=sys-apps/dbus-1.0
	net-libs/libsupld:1
	gconf? (
		>=gnome-base/gconf-2.16
		>=dev-libs/dbus-glib-0.60
		dev-libs/glib:2
	)
	>=sys-libs/glibc-2.5
	>=sys-devel/gcc-3.4.4
'

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	rm -f control.tar.gz data.tar.gz debian-binary
}

src_compile() {
	local preloadsrc="${FILESDIR}/preload.c"
	preloadsrc="${preloadsrc} ${FILESDIR}/preload_init.c"
	if ! use gconf; then
		while read offs sz; do
			dd if=/dev/zero bs=1 count="$sz" seek="$offs" of="./usr/sbin/${MyPN}" conv=notrunc
		done < "${FILESDIR}/${P}.zeroblks"
		preloadsrc="${preloadsrc} ${FILESDIR}/preload_gtk.c"
	fi
	cc ${CFLAGS} -shared -fPIC -ldl $preloadsrc -o libgps5300faker.so ||
		die "Failed to compile gps5300faker"
}

src_install() {
	newsbin "./usr/sbin/${MyPN}" "${PN}"
	dolib.so "libgps5300faker.so"
	dodoc ./usr/share/doc/${MyPN}/copyright
	dodoc ./usr/share/doc/${MyPN}/changelog.gz
	keepdir /var/lib/gps

	# Gentoo-oriented init script
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
}

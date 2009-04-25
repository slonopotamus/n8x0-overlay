DESCRIPTION="binary driver for GPS5300 gps chip"
HOMEPAGE="http://nokia.com"
LICENSE="CopyrightNokia"
MyPN="${PN/5300/}"

SRC_URI="http://timeless.justdave.net/repository/catalogue.tableteer.nokia.com/updates/diablo/${MyPN}_${PV}_armel.deb"
SLOT="0"
KEYWORDS="-* ~arm"
IUSE="gconf"

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
	preloadsrc="${FILESDIR}/preload_init.c"
	if ! use gconf; then
		while read offs sz; do
			dd if=/dev/zero bs=1 count="$sz" seek="$offs" of="./usr/sbin/${MyPN}"
		done < "${FILESDIR}/${P}.zeroblks"
		preloadsrc="${preloadsrc} ${FILESDIR}/preload_gtk.c"
	fi
	cc ${CFLAGS} -fPIC -ldl $preloadsrc -o libgps5300faker.so
}

src_install() {
	newsbin "./usr/sbin/${MyPN}" "${PN}"
	dolib.so "libgps5300faker.so"
	dodoc ./usr/share/doc/${MyPN}/copyright
	dodoc ./usr/share/doc/${MyPN}/changelog.gz
	
	# Gentoo-oriented init script
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
}

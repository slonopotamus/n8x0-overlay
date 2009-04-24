DESCRIPTION="Library for interfacing supl-daemon."
HOMEPAGE="http://nokia.com"
LICENSE="BSD NoSourceAvailable"

SRC_URI="http://timeless.justdave.net/repository/catalogue.tableteer.nokia.com/updates/diablo/${PN}1_${PV}_armel.deb"
SLOT="1"
KEYWORDS="-* ~arm"
IUSE=""

DEPEND=''
RDEPEND="${DEPEND}"'
	>=sys-libs/glibc-2.5
	>=sys-devel/gcc-3.4.4
'

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz 
	rm -f control.tar.gz data.tar.gz debian-binary
}

src_install() {
	dolib.so ./usr/lib/${PN}.so*
	dodoc ./usr/share/doc/${PN}1/copyright
	dodoc ./usr/share/doc/${PN}1/changelog.gz
}

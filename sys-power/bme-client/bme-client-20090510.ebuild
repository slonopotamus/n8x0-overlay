DESCRIPTION="Simple command-line Battery Management Entity client"
HOMEPAGE="http://wiki.maemo.org/Mer/Documentation/BME_Protocol"
LICENSE="Unknown"

SLOT='0'
KEYWORDS='~arm'
SRC_URI="http://bowman.infotech.monash.edu.au/~pmoulder/${PN}.c"
IUSE=''

DEPEND='
'
RDEPEND='
	sys-apps/nit-bootmenu-compat
'

S="${WORKDIR}"

src_unpack() {
	sed 's:/tmp/:/var/run/nokia/:' < "${DISTDIR}/${A}" > "${S}/${PN}.c"
}

src_compile() {
	cc ${CFLAGS} ${LDFLAGS} "${PN}.c" -o "${PN}"
}

src_install() {
	dobin "${PN}"
}

DESCRIPTION="Console keymap modifier for Nokia N810"
HOMEPAGE=""
LICENSE="as-is"

SRC_URI=""
SLOT="0"
KEYWORDS="~arm"

IUSE=""

RDEPEND="
	sys-apps/kbd
"

S="${WORKDIR}"

src_install() {
	insinto '/usr/share/keymaps/i386/qwerty/'
	doins "${FILESDIR}/n810.map.gz"
	dosym 'n810.map.gz' 'nIQP.map.gz'
	dosym 'n810.map.gz' 'nseries.map.gz'
}

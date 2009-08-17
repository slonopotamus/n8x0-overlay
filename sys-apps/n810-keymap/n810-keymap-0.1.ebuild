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

KEYMAPS_DIR="/usr/share/keymaps/i386/qwerty/"

src_install() {
	insinto "${KEYMAPS_DIR}"
	doins "${FILESDIR}/n810.map.gz"
	dosym 'n810.map.gz' "${KEYMAPS_DIR}/nIQP.map.gz"
	dosym 'n810.map.gz' "${KEYMAPS_DIR}/nseries.map.gz"
}

EGIT_REPO_URI="git://gitorious.org/mbx-n8x0/mbx-n8x0-modules.git"

inherit linux-mod git

DESCRIPTION="OpenGL ES acceleration for Nokia N8x0: kernel half"
HOMEPAGE="http://gitorious.org/mbx-n8x0"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND="sys-apps/modutils"
DEPEND="${RDEPEND}
	sys-apps/sed
	virtual/linux-sources
	dev-vcs/git
"

BUILD_TARGETS="all"
BUILD_PARAMS="KERNELDIR=${KERNEL_DIR}"
MODULE_NAMES="
		mbxaccess(kernel/drivers/gpu)
		omaplcd(kernel/drivers/video)
"

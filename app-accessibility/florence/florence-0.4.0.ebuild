# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit gnome2

EAPI=2
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
DESCRIPTION="Extensible scalable virtual keyboard for GNOME"
KEYWORDS="~arm"
SLOT="0"
IUSE="doc"
LICENSE="GPL-2"
HOMEPAGE="http://florence.sourceforge.net/"

# TODO: check whether deps are declared correctly
RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-extra/at-spi-1
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	dev-libs/libxml2
	x11-libs/cairo
	gnome-base/librsvg"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	sys-devel/gettext
	doc? ( gnome-base/libgnome )"

src_configure() {
	econf $(use_with doc docs)
}

#src_install() {
#	emake DESTDIR="${D}" install || die
#	dodoc AUTHORS ChangeLog NEWS README
#}

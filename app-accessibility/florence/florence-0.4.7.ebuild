# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

inherit gnome2

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
DESCRIPTION="Extensible scalable virtual keyboard for GNOME"
KEYWORDS="arm"
SLOT="0"
IUSE="doc +notify +xtst"
LICENSE="GPL-2"
HOMEPAGE="http://florence.sourceforge.net/"

RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-extra/at-spi-1
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	dev-libs/libxml2
	x11-libs/cairo
	gnome-base/librsvg
	notify? ( x11-libs/libnotify )
	xtst? ( x11-libs/libXtst )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23
	app-text/scrollkeeper
	sys-devel/gettext
	doc? ( >=gnome-base/libgnome-2 )"
DOCS="AUTHORS ChangeLog NEWS README"

src_configure() {
	econf $(use_with doc docs) \
	  $(use_with notify notification) \
	  $(use_with xtst) \
	  --with-xkb
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

inherit eutils autotools versionator

MY_P="${PN}_$(replace_version_separator 3 '-' $(get_version_component_range 1-4))"
SRC_URI="http://repository.maemo.org/pool/maemo4.1/free/o/${PN}/${MY_P}.tar.gz"
KEYWORDS="~arm"
SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="DSP loader for OSSO Multimedia framework"
HOMEPAGE="http://maemo.org/"
IUSE=""
DEPEND="
	sys-devel/automake:1.7
	media-sound/osso-dsp-modules
"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_prepare() {
	epatch "${FILESDIR}/${MY_P}deblet$(get_version_component_range 5)mer$(get_version_component_range 6).patch"
	eautoreconf
}

src_configure() {
	econf --enable-tweaks --enable-hash
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"
}

pkg_postinst() {
	einfo "Please add '${PN}' init script to boot services"
	einfo "by running: rc-update add ${PN} boot"
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

K_SECURITY_UNSUPPORTED=1
K_NOSETEXTRAVERSION=1
ETYPE="sources"
inherit kernel-2 eutils versionator
detect_version

MY_PN="kernel-source-diablo"
MY_P="${MY_PN}_${PV}"
MY_PATCH="${MY_P}-200842maemo1.diff.gz"
SRC_DIR="http://repository.maemo.org/pool/maemo4.1.2/free/k/${MY_PN}"

DESCRIPTION="Maemo Linux kernel"
HOMEPAGE="http://www.maemo.org"
SRC_URI="${SRC_DIR}/${MY_P}.orig.tar.gz
	${SRC_DIR}/${MY_PATCH}"

KEYWORDS="~arm"
IUSE=""

src_unpack() {
	unpack "${MY_P}.orig.tar.gz"
	local dir="${MY_PN}-${PV}"
	mv "${MY_PN}" "${dir}" || die
	epatch "${DISTDIR}/${MY_PATCH}"
	epatch "${FILESDIR}/no-crosscompile.patch"
	epatch "${FILESDIR}/missing-limits-h.patch"
	rm -rf "${dir}/debian"
	mv "${dir}/kernel-source" "${S}"

	cd "${S}"

	# Everything below was copied from kernel-2.eclass

	# remove all backup files
	find . -iname "*~" -exec rm {} \; 2> /dev/null

	[[ -z ${K_NOSETEXTRAVERSION} ]] && unpack_set_extraversion
	unpack_fix_install_path

	# Setup xmakeopts and cd into sourcetree.
	env_setup_xmakeopts
	cd "${S}"

	# We dont need a version.h for anything other than headers
	# at least, I should hope we dont. If this causes problems
	# take out the if/fi block and inform me please.
	# unpack_2_6 should now be 2.6.17 safe anyways
	if [[ ${ETYPE} == headers ]]; then
	        kernel_is 2 4 && unpack_2_4
	        kernel_is 2 6 && unpack_2_6
	fi
}

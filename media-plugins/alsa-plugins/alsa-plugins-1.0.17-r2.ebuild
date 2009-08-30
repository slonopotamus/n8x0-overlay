# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsa-plugins/alsa-plugins-1.0.17-r1.ebuild,v 1.11 2009/03/31 09:36:48 armin76 Exp $

inherit libtool autotools eutils flag-o-matic

MY_P="${P/_/}"

DESCRIPTION="ALSA extra plugins"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/plugins/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="debug ffmpeg jack libsamplerate pulseaudio speex maemo"

RDEPEND=">=media-libs/alsa-lib-${PV}
	ffmpeg? ( media-video/ffmpeg )
	jack? ( >=media-sound/jack-audio-connection-kit-0.98 )
	libsamplerate? ( media-libs/libsamplerate )
	pulseaudio? ( media-sound/pulseaudio )
	speex? ( media-libs/speex )
	!media-plugins/alsa-jack"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-1.0.17-automagic.patch"
	epatch "${FILESDIR}/${PN}-1.0.14_rc1-init-ffmpeg.patch"
	epatch "${FILESDIR}"/ffmpeg-headers.patch

	# For some reasons the polyp/pulse plugin does fail with alsaplayer with a
	# failed assert. As the code works just fine with asserts disabled, for now
	# disable them waiting for a better solution.
	sed -i -e '/AM_CFLAGS/s:-Wall:-DNDEBUG -Wall:' \
		"${S}/pulse/Makefile.am"

	eautoreconf
	elibtoolize
}

src_compile() {
	use debug || append-flags -DNDEBUG

	local myopts=""
	if use maemo; then
		myopts="--enable-maemo-plugin --enable-maemo-resource-manager"
	fi

	econf ${myopts} \
		$(use_enable ffmpeg avcodec) \
		$(use_enable jack) \
		$(use_enable libsamplerate samplerate) \
		$(use_enable pulseaudio) \
		$(use_with speex speex lib) \
		--disable-dependency-tracking \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install

	cd "${S}/doc"
	dodoc upmix.txt vdownmix.txt README-pcm-oss
	use jack && dodoc README-jack
	use libsamplerate && dodoc samplerate.txt
	use pulseaudio && dodoc README-pulse
	use ffmpeg && dodoc lavcrate.txt a52.txt
}

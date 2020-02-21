# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="A fork of DOSBox, with patches and more features"
HOMEPAGE="https://dosbox-x.com/"
SRC_URI="https://github.com/joncampbell123/${PN}/archive/${PN}-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"
IUSE="alsa debug hardened ffmpeg opengl +sdl2"

DEPEND="alsa? ( media-libs/alsa-lib )
	ffmpeg? ( media-video/ffmpeg )
	opengl? ( virtual/glu virtual/opengl )
	debug? ( sys-libs/ncurses:0 )
	sdl2? (
		media-libs/libsdl2[X,joystick,video,sound]
		media-libs/sdl2-net
	)
	!sdl2? (
		media-libs/libsdl[X,joystick,video,sound]
		media-libs/sdl-net
	)
	media-libs/libpng"
RDEPEND=${DEPEND}

S="${WORKDIR}/${PN}-${PN}-v${PV}"

src_prepare() {
	default
	eautoreconf
	chmod +x vs2015/sdl/build-scripts/strip_fPIC.sh
	chmod +x configure
	if use !sdl2; then
		# Prefer to compile against the internal copy of SDL 1.x
		(cd vs2015/sdl && ./build-dosbox.sh) || exit 1
	fi
}

src_configure() {
	econf \
		$(use_enable alsa alsa-midi) \
		$(use_enable ffmpeg avcodec) \
		$(use_enable !hardened dynamic-core) \
		$(use_enable !hardened core-inline) \
		$(use_enable !sdl2 sdl) \
		$(use_enable sdl2) \
		$(use_enable debug) \
		$(use_enable opengl)
}

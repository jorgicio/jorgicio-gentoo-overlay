# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop toolchain-funcs xdg

MY_PN="NBlood"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Blood port based in EDuke32"
HOMEPAGE="https://nukeykt.retrohost.net"
SRC_URI="https://github.com/nukeykt/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BUILDLIC GPL-2"
SLOT="0"
IUSE="flac fluidsynth gtk opengl pulseaudio server timidity tools vorbis vpx xmp"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/${MY_P}"

RDEPEND="
	media-libs/libpng:0=
	media-libs/libsdl2[video,sound,opengl,pulseaudio?]
	media-libs/sdl2-mixer[flac?,midi,vorbis?,timidity?,fluidsynth?]
	sys-libs/zlib
	flac? ( media-libs/flac )
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis )
	opengl? (
		virtual/glu
		virtual/opengl )
	gtk? ( x11-libs/gtk+:2 )
	vpx? ( media-libs/libvpx:= )
	xmp? ( media-libs/exempi:2= )"
DEPEND="${RDEPEND}
	timidity? ( media-sound/timidity++ )"
BDEPEND="
	x86? ( dev-lang/nasm )
	media-gfx/imagemagick:0"

src_prepare() {
	sed -i -e "s|/etc/timidity|/etc|g" \
		source/blood/src/sdlmusic.cpp
	default
}

src_compile() {
	local myemakeopts=(
		AS=$(tc-getAS)
		CC=$(tc-getCC)
		CXX=$(tc-getCXX)
		PACKAGE_REPOSITORY=1
		REVFLAG="-DREV=\\\"v${PV}\\\""
		HAVE_GTK=$(usex gtk 1 0)
		HAVE_FLAC=$(usex flac 1 0)
		HAVE_VORBIS=$(usex vorbis 1 0)
		HAVE_XMP=$(usex xmp 1 0)
		POLYMER=$(usex opengl 1 0)
		MIXERTYPE=SDL
		SDL_TARGET=2
		STRIP=""
		NOASM=0
		RENDERTYPE=SDL
		USE_OPENGL=$(usex opengl 1 0)
		USE_LIBVPX=$(usex vpx 1 0)
		NETCODE=$(usex server 1 0)
		OPTLEVEL=0
		LUNATIC=0
		STARTUP_WINDOW=$(usex gtk 1 0)
		STANDALONE=0
	)
	emake "${myemakeopts[@]}"
	use tools && emake utils "${myemakeopts[@]}"
	MAGICK_OCL_DEVICE=OFF convert \
		source/blood/rsrc/game.bmp \
		-gravity center \
		-crop 200x200+0+0 \
		-rotate 90 \
		-resize 192x192 \
		${PN}.png
}

src_install() {
	dobin ${PN}
	if use tools; then
		local tools=(
			arttool
			bsuite
			cacheinfo
			generateicon
			getdxdidf
			givedepth
			ivfrate
			kextract
			kgroup
			kmd2tool
			makesdlkeytrans
			map2stl
			md2tool
			mkpalette
			transpal
			unpackssi
			wad2art
			wad2map
		)
		dobin "${tools[@]}"
	fi

	keepdir /usr/share/games/${PN}
	insinto /usr/share/games/${PN}
	doins ${PN}.pk3
	doicon -s 192 -t hicolor ${PN}.png
	make_desktop_entry ${PN} "${MY_PN}" ${PN} "Game;ActionGame;"
}

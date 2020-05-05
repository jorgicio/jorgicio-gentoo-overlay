# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop git-r3 xdg

MY_PN="NBlood"

DESCRIPTION="Blood port based in EDuke32"
HOMEPAGE="https://nukeykt.retrohost.net"
EGIT_REPO_URI="https://github.com/nukeykt/${MY_PN}"

LICENSE="GPL-2"
SLOT="0"
IUSE="pulseaudio"
RESTRICT="strip"

DEPEND="
	media-libs/flac
	media-libs/libogg
	media-libs/libsdl2[video,sound,opengl,pulseaudio?]
	media-libs/libvorbis
	media-libs/sdl2-mixer[flac,midi,vorbis,timidity]
	media-sound/timidity++
	virtual/glu
	virtual/opengl
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/nasm
	media-gfx/imagemagick:0"

src_prepare() {
	sed -i -e "s|/etc/timidity|/etc|g" \
		source/blood/src/sdlmusic.cpp
	default
}

src_compile() {
	emake PACKAGE_REPOSITORY=1
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
	insinto /usr/share/games/${PN}
	doins ${PN}.pk3
	doicon -s 192 -t hicolor ${PN}.png
	make_desktop_entry ${PN} "${MY_PN}" ${PN} "Game;ActionGame;"
}

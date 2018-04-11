# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
LANGS=(ar da de el es fr it ja ko lt nl pl_PL pt_BR pt ru sv tr zh_CN zh_TW)

inherit cmake-utils

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="https://yabause.org/"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Yabause/${PN}.git"
	KEYWORDS=""
	S=${WORKDIR}/${P}/${PN}
else
	MY_PV=$(replace_version_separator 3 '-')
	MY_P="${PN}-${MY_PV}"

	SRC_URI="https://download.tuxfamily.org/${PN}/releases/${MY_PV}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="ffmpeg network openal opengl optimized-dma pic qt5 sdl ${LANGS[@]/#/l10n_}"

RDEPEND="
	x11-libs/libXrandr
	ffmpeg? ( media-video/ffmpeg )
	openal? ( media-libs/openal )
	opengl? (
		media-libs/freeglut
		virtual/glu
		virtual/opengl
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		opengl? ( dev-qt/qtopengl:5 )
	)
	!qt5? (
		dev-libs/glib:2
		x11-libs/gtk+:2
		x11-libs/gtkglext
	)
	sdl? ( media-libs/libsdl2[opengl?,video] )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS ChangeLog README )

src_prepare() {
	PATCHES=(
		"${FILESDIR}"/${PN}-0.9.14-RWX.patch
		"${FILESDIR}"/${P}-cmake.patch
	)
	default
}

src_configure() {
	local langs="" x
	for x in ${LANGS[@]}; do
		use l10n_${x} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DYAB_OPTIMIZATION=""
		-DLANGS="\"${langs}\""
		-DSH2_DYNAREC=$(usex pic OFF ON)
		-DYAB_WANT_MPEG=$(usex ffmpeg ON OFF)
		-DYAB_WANT_OPENAL=$(usex openal ON OFF)
		-DYAB_WANT_OPENGL=$(usex opengl ON OFF)
		-DYAB_WANT_SDL=$(usex sdl ON OFF)
		-DYAB_PORTS=$(usex qt5 "qt" "gtk")
		-DYAB_NETWORK=$(usex network ON OFF)
		-DYAB_OPTIMIZED_DMA=$(usex optimized-dma ON OFF)
	)

	cmake-utils_src_configure
}

# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils desktop

DESCRIPTION="A 3D-accelerated Doom source port based on ZDoom code"
HOMEPAGE="https://gzdoom.drdteam.org/"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/coelckers/gzdoom.git"
else
	SRC_URI="https://zdoom.org/files/gzdoom/src/${PN}-src-g${PV}.zip"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-g${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+gtk3 vulkan"

RDEPEND="
	gtk3? ( x11-libs/gtk+:3 )
	media-libs/libsdl2
	virtual/glu
	virtual/jpeg-compat:62
	virtual/opengl"

DEPEND="${RDEPEND}
	vulkan? (
		media-libs/vulkan-loader
		dev-util/glslang
	)
	media-libs/mesa[vulkan?]
	|| ( dev-lang/nasm dev-lang/yasm )"

PATCHES=( "${FILESDIR}/${PN}-${PV:0:3}-force-static-libs.patch" )

src_prepare() {
	# Use default data path
	sed -i -e "s:/usr/local/share/:/usr/share/doom-data/:" src/posix/i_system.h
	sed -i -e '/SetValueForKey ("Path", "\/usr\/share\/games\/doom", true);/ a \\t\tSetValueForKey ("Path", "/usr/share/doom-data", true);' \
		src/gameconfigfile.cpp
	sed -i -e '/SetValueForKey ("Path", "\/usr\/share\/games\/doom\/soundfonts", true);/ a \\t\tSetValueForKey ("Path", "/usr/share/doom-data/soundfonts", true);' \
		src/gameconfigfile.cpp
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DNO_GTK="$(usex gtk3 no yes)"
		-DHAVE_VULKAN="$(usex vulkan yes no)"
	)
	cmake-utils_src_configure
}

src_install() {
	dodoc docs/{*.txt,console*.{css,html}}
	newicon "src/posix/zdoom.xpm" "${PN}.xpm"
	make_desktop_entry "${PN}" "GZDoom" "${PN}" "Game;ActionGame;"

	cd "${BUILD_DIR}"

	insinto "${EPREFIX}/usr/share/doom-data"
	doins *.pk3
	insinto "${EPREFIX}/usr/share/doom-data/soundfonts"
	doins soundfonts/*.sf2
	dobin "${PN}"
}

pkg_postinst() {
	echo
	elog 'Copy or link wad files into /usr/share/doom-data/ or $HOME/.config/gzdoom/'
	elog "ATTENTION: The path has changed! It used to be /usr/share/games/doom-data/"
	elog
	elog "Starting from GZDoom 3.3.0, TiMidity++ is now an internal MIDI player."
	elog "Unfortunately, it does not support system soundfonts directly."
	elog "To make them selectable, turn '/usr/share/timidity/foo' into a zip archive and put it"
	elog 'into /usr/share/doom-data/soundfonts/ or $HOME/.config/gzdoom/soundfonts/'
	elog
	elog "To play, simply run:"
	elog "   gzdoom"
	elog
	if use vulkan; then
		elog "Warning: you have enabled Vulkan support,"
		elog "which is currently experimental. Check first"
		elog "if your video card supports it. Use it at"
		elog "your own risk."
		elog "To enable it, use \"+vid_backend 0\" on the command line."
		elog "Set that value to 1 instead if you want to go back to OpenGL."
	fi
	echo
}

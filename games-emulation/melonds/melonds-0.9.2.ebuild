# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop xdg

MY_PN="melonDS"

DESCRIPTION="Nintendo DS emulator, sorta. Also 1st quality melon."
HOMEPAGE="http://melonds.kuribo64.net"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Arisotura/${MY_PN}"
else
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/Arisotura/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+opengl"

DEPEND="
	app-arch/libarchive
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-libs/libsdl2[sound,video]
	net-libs/libpcap
	net-libs/libslirp
	opengl? ( media-libs/libepoxy )"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_OGLRENDERER=$(usex opengl)
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	echo
	elog "You will need the following files in order to use melonDS:"
	elog "- bios7.bin"
	elog "- bios9.bin"
	elog "- firmware.bin"
	elog "Configure the paths for them in Config > Emu settings > DS-mode."
	elog "These can be found somewhere on the internet."
	echo
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop xdg

MY_PN="melonDS"

DESCRIPTION="NintendoDS emulator, sorta. Also 1st quality melon."
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

DEPEND="
	media-libs/libsdl2[sound,video]
	net-libs/libpcap
	net-misc/curl
	x11-libs/cairo
	x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare
}

pkg_postinst() {
	xdg_pkg_postinst
	echo
	elog "You need the following files in order to run melonDS:"
	elog "- bios7.bin"
	elog "- bios9.bin"
	elog "- firmware.bin"
	elog "- romlist.bin"
	elog "Place them in the same directory you're running melonDS."
	elog "The romlist.bin file can be found in the /usr/share/${MY_PN} directory,"
	elog "while the other files can be found somewhere in the internet."
	echo
}

# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils desktop xdg-utils

DESCRIPTION="NintendoDS emulator, sorta. Also 1st quality melon."
HOMEPAGE="http://melonds.kuribo64.net"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Arisotura/melonDS"
else
	SRC_URI="https://github.com/Arisotura/melonDS/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/melonDS-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/gtk+:3
	x11-libs/cairo
	net-misc/curl
	net-libs/libpcap
	media-libs/libsdl2[sound,video]
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s#net.kuribo64.melonds#melonds#" flatpak/net.kuribo64.melonds.desktop
	cmake-utils_src_prepare
}

src_install() {
	cmake-utils_src_install
	domenu flatpak/net.kuribo64.melonds.desktop
	for size in 16 32 48 64 128 256; do
		newicon -s ${size} icon/melon_${size}x${size}.png ${PN}.png
	done
}

pkg_postinst() {
	xdg_desktop_database_update
	echo
	elog "You need the following files in order to run DS roms:"
	elog "- bios7.bin"
	elog "- bios9.bin"
	elog "- firmware.bin"
	echo
}

pkg_postrm() {
	xdg_desktop_database_update
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="Quakeworld client with mqwcl functionality and many more features"
HOMEPAGE="https://ezquake.github.io"
SRC_URI="https://github.com/ezquake/ezquake-source/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdinstall"

DEPEND="
	dev-libs/expat
	dev-libs/jansson
	dev-libs/openssl:0
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libsdl2
	net-misc/curl
	sys-libs/zlib[minizip]
"
RDEPEND="${DEPEND}
	virtual/opengl
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	cdinstall? ( games-fps/quake1-data )"

S="${WORKDIR}/${PN}-source-${PV}"

PATCHES=( "${FILESDIR}/${PN}-3.1-unbreak-gentoo-minizip.patch" )

dir="/usr/share/${PN}"

src_install() {
	exeinto ${dir}
	newexe ${PN}-linux-$(uname -m) ${PN}
	insinto ${dir}
	doins "${FILESDIR}/pak.lst"
	domenu "${FILESDIR}/${PN}.desktop"
	doicon "${FILESDIR}/${PN}.ico"
	dobin "${FILESDIR}/${PN}"
	dodir "${dir}/id1"
	dodir "${dir}/qw"
	dodir "${dir}/qw/save"
	chgrp users "${ED}/${dir}/qw/save"
}

pkg_postinst() {
	xdg_pkg_postinst
	if ! use cdinstall; then
		elog "NOTE that this client doesn't include .pak files. You *should*"
		elog "enable \"cdinstall\" flag or install quake1-demodata with the symlink use flag."
		elog "You can also copy the files from your Quake1 CD to"
		elog "  ${dir}/id1 (all names lowercase)"
		elog ""
		elog "You may also want to check:"
		elog " http://fuhquake.quakeworld.nu - complete howto on commands and variables"
		elog " http://equake.quakeworld.nu - free package containing various files"
	fi
}

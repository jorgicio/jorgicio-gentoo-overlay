# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg

MY_P=${P/-/_}

DESCRIPTION="A mix from Nintendo's Super Mario Bros and Valve's Portal"
HOMEPAGE="http://stabyourself.net/mari0/"
SRC_URI="https://github.com/Stabyourself/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-NC-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=games-engines/love-11.1:0
	media-libs/devil[gif,png]"
BDEPEND="app-arch/zip"

src_prepare(){
	rm -rf "./_DO NOT INCLUDE" "README.md"
	default
}

src_compile(){
	elog "Creating .love file..."
	zip -9 -r "${MY_P}.love" . && elog "${MY_P}.love created" || die
}

src_install() {
	local dir=/usr/share/${PN}

	exeinto "${dir}"
	doexe ${MY_P}.love

	newicon graphics/icon.png ${PN}.png
	make_wrapper ${PN} "love ${MY_P}.love" "${dir}"
	make_desktop_entry ${PN}
}

pkg_postinst() {
	elog "${PN} savegames and configurations are stored in:"
	elog "~/.local/share/love/${PN}/"

	xdg_pkg_postinst
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils gnome2-utils games

MY_P=${P/-/_}

DESCRIPTION="A mix from Nintendo's Super Mario Bros and Valve's Portal"
HOMEPAGE="http://stabyourself.net/mari0/"
SRC_URI="http://stabyourself.net/dl.php?file=${PN}-1006/${PN}-linux.zip -> ${P}.zip"

LICENSE="CC-BY-NC-SA-3.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=games-engines/love-0.8.0:0.8
	 media-libs/devil[gif,png]"
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_DATADIR}/love/${PN}

	exeinto "${dir}"
	doexe ${MY_P}.love

	doicon -s scalable ${FILESDIR}/${PN}.svg
	games_make_wrapper ${PN} "love ${MY_P}.love" "${dir}"
	make_desktop_entry ${PN}

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	elog "${PN} savegames and configurations are stored in:"
	elog "~/.local/share/love/${PN}/"

	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

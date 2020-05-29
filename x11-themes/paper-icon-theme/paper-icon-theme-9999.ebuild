# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson

DESCRIPTION="Paper is an icon theme for GTK-based desktops"
HOMEPAGE="https://snwh.org/paper"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/snwh/${PN}.git"
else
	SRC_URI="https://github.com/snwh/${PN}/archive/v.${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${PN}-v.${PV}"
fi

LICENSE="CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
}

pkg_postrm(){
	gnome2_icon_cache_update
}

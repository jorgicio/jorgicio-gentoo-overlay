# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils

DESCRIPTION="Paper is an icon theme for GTK-based desktops and fits perfectly the paper-gtk-theme"
HOMEPAGE="https://snwh.org/paper"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/snwh/${PN}.git"
else
	SRC_URI="https://github.com/snwh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare(){
	PATCHES=( "${FILESDIR}/configure.ac.patch" )
	default
	eautoreconf
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
}

pkg_postrm(){
	gnome2_icon_cache_update
}

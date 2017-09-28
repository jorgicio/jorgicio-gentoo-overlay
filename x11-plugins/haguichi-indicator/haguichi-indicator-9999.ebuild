# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"

inherit vala eutils gnome2 meson

DESCRIPTION="An appindicator for Haguichi"
HOMEPAGE="http://www.haguichi.net"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/ztefn/${PN}.git"
else
	SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	$(vala_depend)
	x11-libs/gtk+:3
	dev-libs/libappindicator:3
	net-vpn/haguichi
	"
RDEPEND="${DEPEND}"

pkg_setup(){
	ln -s $(which valac-$(vala_best_api_version)) "${T}/valac" || die
	export PATH="${PATH}:${T}"
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"

inherit vala eutils gnome2 cmake-utils

DESCRIPTION="An appindicator for Haguichi"
HOMEPAGE="http://www.haguichi.net"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="
	$(vala_depend)
	x11-libs/gtk+:3
	dev-libs/libappindicator:3
	net-vpn/haguichi
	"
RDEPEND="${DEPEND}"

src_prepare(){
	DOCS="AUTHORS"
	gnome2_src_prepare
	vala_src_prepare
	export VALAC="$(type -p valac-$(vala_best_api_version))"
}

src_configure(){
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DUSE_VALA_BINARY=$(type -p valac-$(vala_best_api_version))
	)
	cmake-utils_src_configure
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

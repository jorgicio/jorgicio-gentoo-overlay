# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"

inherit eutils vala versionator gnome2 cmake-utils git-r3

MY_BRANCH="$(get_version_component_range 1-2)"

DESCRIPTION="Provides a user friendly GTK+-3 GUI to control the Hamachi client on Linux"
HOMEPAGE="https://www.haguichi.net"
EGIT_REPO_URI="https://github.com/ztefn/haguichi.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	$(vala_depend)
	net-vpn/logmein-hamachi
	x11-libs/gtk+:3
	x11-libs/libnotify
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
		"-DICON_UPDATE=OFF"
		"-DGSETTINGS_COMPILE=OFF"
		"-DUSE_VALA_BINARY=$(type -p valac-$(vala_best_api_version))"
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

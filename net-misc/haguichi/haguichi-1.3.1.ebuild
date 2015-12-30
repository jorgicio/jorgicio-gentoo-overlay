# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"

inherit eutils vala versionator gnome2 cmake-utils

MY_BRANCH="$(get_version_component_range 1-2)"

DESCRIPTION="Provides a user friendly GTK+-3 GUI to control the Hamachi client on Linux"
HOMEPAGE="https://www.haguichi.net"
SRC_URI="http://launchpad.net/${PN}/${MY_BRANCH}/${PV}/+download/${P}.tar.xz"
RESTRICT="mirror"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

DEPEND="
	$(vala_depend)
	net-misc/logmein-hamachi
	x11-libs/gtk+:3
	x11-libs/libnotify
"
RDEPEND="${DEPEND}"

src_prepare(){
	epatch ${FILESDIR}/${PN}-vala-version-finder.patch
	DOCS="AUTHORS"
	gnome2_src_prepare
	vala_src_prepare
}

src_configure(){
	local mycmakeargs=(
		"-DICON_UPDATE=OFF"
		"-DGSETTINGS_COMPILE=OFF"
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

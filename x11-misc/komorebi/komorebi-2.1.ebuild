# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION="0.16"
VALA_USE_DEPEND="vapigen"
CMAKE_MIN_VERSION="2.8"

inherit cmake-utils gnome2 vala

DESCRIPTION="A beautiful, customizable wallpapers manager for Linux"
HOMEPAGE="https://github.com/iabem97/komorebi"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	$(vala_depend)
	>=dev-libs/glib-2.38:2
	x11-libs/gtk+:3
	dev-libs/libgee:0.8
	media-libs/clutter:1.0[introspection,gtk]
	media-libs/clutter-gtk:1.0[introspection,gtk]
	media-libs/clutter-gst:3.0[introspection]
	net-libs/webkit-gtk:4
"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i -e "s/NAMES valac/NAMES valac-$(vala_best_api_version)/" cmake/FindVala.cmake || die
	sed -i '/$ENV{HOME}/d' CMakeLists.txt || die
	find . -type f -exec sed -i 's|/System/Applications/|/usr/bin/|g' {} \;
	find . -type f -exec sed -i 's|/System/Resources/|/usr/share/|g' {} \;
	find . -type f -exec sed -i 's|/Komorebi|/komorebi|g' {} \;
	cmake-utils_src_prepare
}

src_configure(){
	cmake-utils_src_configure
}

src_compile(){
	cmake-utils_src_compile
}

src_install(){
	cmake-utils_src_install
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

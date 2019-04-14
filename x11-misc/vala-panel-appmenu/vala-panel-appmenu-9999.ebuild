# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.24

inherit cmake-utils eutils gnome2-utils git-r3 vala

DESCRIPTION="Global Menu plugin for xfce4 and vala-panel"
HOMEPAGE="https://github.com/rilian-la-te/vala-panel-appmenu"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} == 9999 ]];then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~x86"
	EGIT_COMMIT="${PV}"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="+vala-panel xfce +wnck mate wayland"
#REQUIRED_USE="|| ( xfce vala-panel mate )"

DEPEND="
	>=x11-libs/gtk+-3.22.0:3[wayland?]
	$(vala_depend)
	virtual/pkgconfig
	sys-devel/gettext
"
RDEPEND="${DEPEND}
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	>=x11-libs/bamf-0.5.0
	wnck? ( >=x11-libs/libwnck-3.4.7 )
	vala-panel? ( x11-misc/vala-panel )
	xfce? ( >=xfce-base/xfce4-panel-4.11.2 )
	mate? ( >=mate-base/mate-panel-1.20.0 )
"

src_prepare(){
	if use !wayland;then
		sed -i 's/WAYLAND//' CMakeLists.txt
		sed -i 's/WAYLAND//' subprojects/appmenu-gtk-module/CMakeLists.txt
		sed -i 's/\${WAYLAND_INCLUDE}//'  subprojects/appmenu-gtk-module/src/CMakeLists.txt
	fi
	vala_src_prepare
	cmake-utils_src_prepare
}

src_configure(){
	local mycmakeargs=(
		-DENABLE_XFCE=$(usex xfce ON OFF)
		-DENABLE_VALAPANEL=$(usex vala-panel ON OFF)
		-DENABLE_WNCK=$(usex wnck ON OFF)
		-DENABLE_MATE=$(usex mate ON OFF)
		-DENABLE_APPMENU_GTK_MODULE=ON
		-DGSETTINGS_COMPILE=OFF
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

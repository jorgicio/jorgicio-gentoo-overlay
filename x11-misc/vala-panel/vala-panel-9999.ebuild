# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
VALA_MIN_API_VERSION=0.34

inherit cmake-utils eutils git-r3 gnome2-utils vala

DESCRIPTION="Lightweight desktop panel"
HOMEPAGE="https://github.com/rilian-la-te/vala-panel"
EGIT_REPO_URI="${HOMEPAGE}.git"
SRC_URI=""

if [[ ${PV} == 9999 ]];then
	KEYWORDS=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="+wnck +X"
GNOME2_ECLASS_GLIB_SCHEMAS="org.valapanel.gschema.xml"

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
	sys-devel/gettext
	>=dev-libs/glib-2.56.0
"
RDEPEND="${DEPEND}
	>=x11-libs/gtk+-3.22.0:3[wayland]
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	>=dev-libs/libpeas-1.2.0
	X? ( x11-libs/libX11 )
	wnck? ( >=x11-libs/libwnck-3.4.0:3 )
"

src_prepare(){
	vala_src_prepare
	cmake-utils_src_prepare
}

src_configure(){
	local mycmakeargs=(
		-DWNCK=$(usex wnck ON OFF)
		-DX11=$(usex X ON OFF)
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		-DCMAKE_INSTALL_SYSCONFDIR=/etc
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

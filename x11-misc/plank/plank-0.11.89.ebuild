# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.26
VALA_USE_DEPEND=vapigen

inherit autotools gnome2-utils vala

DESCRIPTION="Dock panel famous docky"
HOMEPAGE="https://launchpad.net/plank"
SRC_URI="https://launchpad.net/${PN}/1.0/${PV}/+download/${P}.tar.xz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection doc static-libs"

DEPEND="
	$(vala_depend)
	dev-util/intltool
	gnome-base/gnome-common
	gnome-base/gnome-menus
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	x11-libs/gtk+:3
	x11-libs/bamf
	x11-libs/libX11
	dev-libs/libdbusmenu
	x11-libs/libwnck:3
"
DOCS=( AUTHORS COPYRIGHT )

src_prepare(){
	eautoreconf
	vala_src_prepare
	default
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

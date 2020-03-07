# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

DESCRIPTION="Markdown editor made with GTK+-3.0"
HOMEPAGE="https://fabiocolacio.github.io/Marker"
SRC_URI="https://github.com/fabiocolacio/${PN^}/releases/download/${PV}/${PV}.tar.xz -> ${P}.tar.xz"

KEYWORDS="~x86 ~amd64"

LICENSE="GPL-3 ISC"
SLOT="0"
IUSE="pandoc"

DEPEND="x11-libs/gtk+:3
	x11-libs/gtksourceview:3.0/3
	net-libs/webkit-gtk:4/37
	app-text/gtkspell:3/0
"
RDEPEND="${DEPEND}
	pandoc? ( app-text/pandoc )
"

S="${WORKDIR}/${PN^}"

src_prepare(){
	sed -i 's/en_US/C/' src/scidown/src/charter/src/svg.c || die
	default
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_pkg_postrm
}

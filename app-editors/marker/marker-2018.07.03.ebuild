# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3 gnome2-utils xdg-utils

DESCRIPTION="Markdown editor made with GTK+-3.0"
HOMEPAGE="https://fabiocolacio.github.io/Marker"
SRC_URI=""
EGIT_REPO_URI="https://github.com/fabiocolacio/${PN^}"
if [[ ${PV} == 9999 ]];then
	KEYWORDS=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

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

src_prepare(){
	sed -i 's/en_US/C/' src/scidown/src/charter/src/svg.c
	default
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_desktop_database_update
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

SCIDOWN_COMMIT="a7b7f063de4f272ef0ec12d00b98470888e8cb32"
CHARTER_COMMIT="a25dee1214ea9ba5882325066555cb813efbb489"
TINYEXPR_COMMIT="9476568b69de4c384903f1d5f255907b92592f45"

DESCRIPTION="Markdown editor made with GTK+-3.0"
HOMEPAGE="https://fabiocolacio.github.io/Marker"
SRC_URI="
	https://github.com/fabiocolacio/${PN^}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Mandarancio/scidown/archive/${SCIDOWN_COMMIT}.tar.gz -> scidown-${SCIDOWN_COMMIT}.tar.gz
	https://github.com/Mandarancio/charter/archive/${CHARTER_COMMIT}.tar.gz -> charter-${CHARTER_COMMIT}.tar.gz
	https://github.com/codeplea/tinyexpr/archive/${TINYEXPR_COMMIT}.tar.gz -> tinyexpr-${TINYEXPR_COMMIT}.tar.gz"

KEYWORDS="~amd64 ~x86"

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

S="${WORKDIR}/${PN^}-${PV}"

src_prepare(){
	rmdir "${S}/src/scidown" \
		"${WORKDIR}/scidown-${SCIDOWN_COMMIT}/src/charter" \
		"${WORKDIR}/charter-${CHARTER_COMMIT}/src/tinyexpr" || die
	mv "${WORKDIR}/tinyexpr-${TINYEXPR_COMMIT}" "${WORKDIR}/charter-${CHARTER_COMMIT}/src/tinyexpr" || die
	mv "${WORKDIR}/charter-${CHARTER_COMMIT}" "${WORKDIR}/scidown-${SCIDOWN_COMMIT}/src/charter" || die
	mv "${WORKDIR}/scidown-${SCIDOWN_COMMIT}" "${S}/src/scidown" || die
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

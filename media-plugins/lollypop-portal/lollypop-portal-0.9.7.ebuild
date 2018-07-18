# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit python-r1 eutils gnome2-utils meson

DESCRIPTION="Advanced features for Lollypop"
HOMEPAGE="https://wiki.gnome.org/Apps/Lollypop"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://gitlab.gnome.org/gnumdk/${PN}"
	KEYWORDS=""
else
	SRC_URI="https://gitlab.gnome.org/gnumdk/${PN}/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="x86 amd64 ~arm"
fi


LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	>=x11-libs/gtk+-3.14.0:3
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=dev-libs/gobject-introspection-1.35.9[cairo]
	dev-python/pkgconfig[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

src_prepare(){
	PATCHES=(
		"${FILESDIR}/${PN}-fix-python-search.patch"
	)
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

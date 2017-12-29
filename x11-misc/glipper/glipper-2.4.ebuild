# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 xdg-utils gnome2-utils

DESCRIPTION="Clipboard manager for GNOME"
HOMEPAGE="https://launchpad.net/glipper"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-python/gconf-python:2[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-libs/keybinder:0[python,introspection,${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	gnome-base/gconf[introspection,${PYTHON_USEDEP}]
	x11-themes/hicolor-icon-theme
"
RDEPEND="${DEPEND}
	>=dev-python/python-distutils-extra-2.37
"

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

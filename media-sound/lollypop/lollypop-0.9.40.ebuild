# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )

inherit python-r1 autotools git-r3 gnome2-utils

DESCRIPTION="Lollypop is a new GNOME music playing application"
HOMEPAGE="https://github.com/gnumdk/${PN}"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="${PV}"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	x11-libs/gtk+:3
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-libs/gobject-introspection[cairo]
	dev-python/pycairo
	dev-python/dbus-python
	dev-libs/totem-pl-parser
	dev-util/itstool
	dev-util/intltool
	gnome-base/gnome-common
"
RDEPEND="${DEPEND}
	dev-util/desktop-file-utils
	>=dev-python/pylast-1.0.0[${PYTHON_USEDEP}]
	dev-python/python-wikipedia[${PYTHON_USEDEP}]"

PYTHON_REQ_USE="sqlite"

src_prepare(){
	eautoreconf
}

src_configure(){
	econf --disable-schemas-compile
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
}

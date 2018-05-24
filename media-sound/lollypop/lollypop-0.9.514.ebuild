# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
PYTHON_REQ_USE="sqlite"

inherit python-r1 gnome2-utils eutils meson

DESCRIPTION="Lollypop is a new GNOME music playing application"
HOMEPAGE="https://wiki.gnome.org/Apps/Lollypop"
if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://gitlab.gnome.org/gnumdk/${PN}"
	KEYWORDS=""
else
	HASH="fc731e0878cea850ebadb46afd69b3b8"
	SRC_URI="https://gitlab.gnome.org/gnumdk/${PN}/uploads/${HASH}/${P}.tar.xz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	>=x11-libs/gtk+-3.20.0:3
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=dev-libs/gobject-introspection-1.35.9[cairo]
	dev-python/pkgconfig[${PYTHON_USEDEP}]
	dev-python/pycairo
	dev-python/dbus-python
	dev-libs/totem-pl-parser
	dev-util/itstool
	dev-util/intltool
	app-crypt/libsecret
	gnome-base/gnome-common
	media-libs/${PN}-portal
"
RDEPEND="${DEPEND}
	dev-util/desktop-file-utils
	dev-libs/appstream-glib[introspection]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/pylast-1.0.0[${PYTHON_USEDEP}]"

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

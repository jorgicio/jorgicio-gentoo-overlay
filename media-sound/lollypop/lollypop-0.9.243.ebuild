# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
PYTHON_REQ_USE="sqlite"

inherit python-r1 autotools gnome2-utils

DESCRIPTION="Lollypop is a new GNOME music playing application"
HOMEPAGE="http://gnumdk.github.io/lollypop"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/gnumdk/lollypop"
	KEYWORDS=""
else
	SRC_URI="https://github.com/gnumdk/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	>=dev-util/meson-0.40[${PYTHON_USEDEP}]
	dev-util/ninja
	>=x11-libs/gtk+-3.14.0:3
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
"
RDEPEND="${DEPEND}
	dev-util/desktop-file-utils
	>=dev-python/pylast-1.0.0[${PYTHON_USEDEP}]"

pkg_setup(){
	export MAKE=ninja
}

src_configure(){
	meson build --prefix=/usr --sysconfdir=/etc --buildtype plain || die
}

src_compile(){
	emake -C "${S}/build"
}

src_install(){
	DESTDIR="${ED}" emake -C "${S}/build" install
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

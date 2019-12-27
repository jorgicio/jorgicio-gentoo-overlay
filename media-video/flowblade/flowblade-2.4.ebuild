# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit desktop python-r1 xdg-utils gnome2-utils

DESCRIPTION="A multitrack non-linear video editor"
HOMEPAGE="https://github.com/jliljebl/flowblade"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	>=x11-libs/gtk+-3.0:3
	dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	>=media-libs/mlt-6.18.0[python,ffmpeg,gtk,${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	media-plugins/frei0r-plugins
	media-plugins/swh-plugins
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/librsvg-python[${PYTHON_USEDEP}]
	gnome-base/librsvg:2
	media-gfx/gmic[ffmpeg,X]
	dev-libs/glib:2[dbus]
	x11-libs/gdk-pixbuf:2[X]
	virtual/ffmpeg
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${P}/${PN}-trunk

pkg_setup() {
	python_setup
}

src_prepare() {
	eapply -p2 "${FILESDIR}/${P}-install-dir-fix.patch"
	default
}

src_install(){
	local filename="io.github.jliljebl.${PN^}"
	python_fix_shebang ${PN}
	dobin ${PN}
	insinto /usr/share/${PN}
	doins -r Flowblade/*
	doman installdata/${PN}.1
	dodoc README
	doicon -s 128 installdata/${filename}.png
	domenu installdata/${filename}.desktop
	insinto /usr/share/mime/packages
	doins installdata/${filename}.xml
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_mime_database_update
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_mime_database_update
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

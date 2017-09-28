# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1 fdo-mime gnome2-utils

DESCRIPTION="A multitrack non-linear video editor"
HOMEPAGE="https://github.com/jliljebl/flowblade"

if [[ ${PV} == *9999 ]];then
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
	media-libs/mlt[python,ffmpeg,gtk,${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	media-plugins/frei0r-plugins
	media-plugins/swh-plugins
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/librsvg-python[${PYTHON_USEDEP}]
	gnome-base/librsvg:2
	media-gfx/gmic[ffmpeg,X]
	dev-libs/glib:2[dbus,${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf:2[X]
	virtual/ffmpeg
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${P}/${PN}-trunk

src_prepare(){
	epatch "${FILESDIR}/${PN}-1.8-install-dir-fix.patch"
	eapply_user
}

src_install(){
	dobin ${PN}
	insinto /usr/share/${PN}
	doins -r Flowblade/*
	doman installdata/${PN}.1
	dodoc README
	doicon -s 128 installdata/${PN}.png
	domenu installdata/${PN}.desktop
	insinto /usr/share/mime/packages
	doins installdata/${PN}.xml
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

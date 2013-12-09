# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
# written for 2.6, works on 2.7 as well
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"
PYTHON_MODNAME="PyRoom"

inherit distutils versionator

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="A minimal word processor that lets you focus on writing"
HOMEPAGE="http://www.pyroom.org/"
SRC_URI="http://launchpad.net/${PN}/${MY_PV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="dev-python/pygobject:2
	dev-python/pygtk:2
	dev-python/pyxdg
	gnome? ( dev-python/gconf-python:2 )"
DEPEND="sys-devel/gettext"

DOCS="AUTHORS CHANGELOG"

LANGS="ar bg br ca cy da de el en_GB eo es eu fi fr ga gu hr hu id it
ja ku lt lv mk nb nl nn pl pt pt_BR ro ru sco sk sl sr sv tr zh_CN"
for l in ${LANGS}; do
	IUSE="$IUSE linguas_${l}"
done
unset l

src_prepare() {
	distutils_src_prepare

	# build system does not filter translations
	local l
	for l in ${LANGS} ; do
		if ! use linguas_${l} ; then
			rm locales/${PN}-${l}.po || die
		fi
	done

	# fix icon-destination
	sed -i -e \
		"/${PN}.png/s:/usr/share/${PN}:/usr/share/pixmaps/:" \
		setup.py || die

	# fix .desktop file
	sed -i -e \
		"/Icon/s:/usr/share/${PN}:/usr/share/pixmaps:" \
		${PN}.desktop || die
}

src_install() {
	distutils_src_install
	doman ${PN}.1
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "If you get an Error like"
	elog "\"AttributeError: 'list' object has no attribute 'encode'\""
	elog "you need to create a startup-script like the following:"
	elog ""
	elog "#!/bin/sh"
	elog "#Script for starting PyRoom"
	elog "unset LANGUAGE"
	elog "${PN}"
}

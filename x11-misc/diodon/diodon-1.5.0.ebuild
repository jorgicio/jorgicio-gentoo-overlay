# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION="0.20"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit waf-utils vala python-single-r1 eutils gnome2-utils

DESCRIPTION="GTK+ clipboard manager"
HOMEPAGE="https://launchpad.net/diodon"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="appindicator"

DEPEND="
	$(vala_depend)
	${PYTHON_DEPS}
	gnome-base/gconf:2
	gnome-base/dconf
	>=dev-libs/libgee-0.10.5:0.8
	dev-libs/libunique:3
	>=dev-libs/libpeas-1.1.0[python,gtk]
	>=x11-libs/libXtst-1.2.0
	appindicator? ( dev-libs/libappindicator:3 )
	>=x11-libs/gtk+-3.10.0:3
"
RDEPEND="${DEPEND}
	>=gnome-extra/zeitgeist-0.9.14[introspection,${PYTHON_USEDEP}]
	dev-util/desktop-file-utils
	x11-base/xorg-server[xvfb]
	"

pkg_setup(){
	python-single-r1_pkg_setup
}

src_prepare(){
	sed -i -e 's:/sbin/ldconfig:/bin/true:g' wscript
	sed -i -e 's:/sbin/ldconfig:/bin/true:g' waflib/Build.py
	PATCHES=( 
		"${FILESDIR}/${PN}-force-bfd.patch"
		"${FILESDIR}/${PN}-generate-schema.patch" 
	)
	epatch ${PATCHES[@]}
	rm -rf tests/*
	touch tests/wscript_build
	eapply_user
}

src_configure(){
	waf-utils_src_configure \
		--notests \
		--nocache \
		--skiptests \
		$(usex appindicator "" --disable-indicator-plugin)
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

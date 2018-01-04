# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION="0.26"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit waf-utils vala python-single-r1 eutils gnome2-utils xdg

DESCRIPTION="GTK+ clipboard manager"
HOMEPAGE="https://launchpad.net/diodon"

if [[ ${PV} == *9999 ]];then
	inherit bzr
	EBZR_REPO_URI="https://code.launchpad.net/${PN}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	$(vala_depend)
	${PYTHON_DEPS}
	gnome-base/gconf:2
	gnome-base/dconf
	>=dev-libs/libgee-0.10.5:0.8
	dev-libs/libunique:3
	>=dev-libs/libpeas-1.1.0[python,gtk]
	>=x11-libs/libXtst-1.2.0
	dev-libs/libappindicator:3
	>=x11-libs/gtk+-3.10.0:3
	x11-base/xorg-server[xvfb]
"
RDEPEND="${DEPEND}
	>=gnome-extra/zeitgeist-0.9.14[introspection,${PYTHON_USEDEP}]
	dev-util/desktop-file-utils
	"

pkg_setup(){
	python-single-r1_pkg_setup
	export VALAC="$(type -p valac-$(vala_best_api_version))"
}

src_prepare(){
	sed -i -e 's:/sbin/ldconfig:/bin/true:g' wscript
	sed -i -e 's:/sbin/ldconfig:/bin/true:g' waflib/Build.py
	PATCHES=( 
		"${FILESDIR}/${PN}-generate-schema.patch" 
		"${FILESDIR}/${PN}-force-bfd.patch"
	)
	eapply ${PATCHES[@]}
	rm -rf tests/*
	touch tests/wscript_build
	eapply_user
}

src_configure(){
	waf-utils_src_configure \
		--notests \
		--nocache \
		--skiptests
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_desktop_database_update
}

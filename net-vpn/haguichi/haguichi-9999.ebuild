# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"

inherit eutils vala gnome2

DESCRIPTION="Provides a user friendly GTK+-3 GUI to control the Hamachi client on Linux"
HOMEPAGE="https://www.haguichi.net"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ztefn/${PN}.git"
	SRC_URI=""
	KEYWORDS=""
else
	inherit versionator
	MY_BRANCH="$(get_version_component_range 1-2)"
	SRC_URI="http://launchpad.net/${PN}/${MY_BRANCH}/${PV}/+download/${P}.tar.xz"
	KEYWORDS="~arm ~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

DEPEND="
	$(vala_depend)
	>=dev-util/meson-0.40
	net-vpn/logmein-hamachi
	>=x11-libs/gtk+-3.14:3
	>=x11-libs/libnotify-0.7.6
	dev-util/ninja
	sys-devel/gettext
"
RDEPEND="${DEPEND}"

pkg_setup(){
	export MAKE=ninja
	ln -s $(which valac-$(vala_best_api_version)) "${T}/valac" || die
	export PATH="${PATH}:${T}"
}

src_prepare(){
	DOCS="AUTHORS"
	gnome2_src_prepare
	vala_src_prepare
}

src_configure(){ 
	meson build --prefix=${EPREFIX}/usr --sysconfdir=${EPREFIX}/etc --buildtype plain || die
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

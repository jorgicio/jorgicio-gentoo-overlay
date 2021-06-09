# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION="0.30"
VALA_USE_DEPEND="vapigen"

inherit gnome2-utils meson vala

DESCRIPTION="Provides a user friendly GTK+-3 GUI to control the Hamachi client on Linux"
HOMEPAGE="https://www.haguichi.net"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ztefn/${PN}.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://launchpad.net/${PN}/${PV:0:3}/${PV}/+download/${P}.tar.xz"
	KEYWORDS="-* ~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="appindicator"

DEPEND="
	$(vala_depend)
	net-vpn/logmein-hamachi
	>=x11-libs/gtk+-3.18:3
	>=x11-libs/libnotify-0.7.6
	sys-devel/gettext
	>=dev-libs/glib-2.48:2
	appindicator? ( dev-libs/libappindicator:3 )
"
RDEPEND="${DEPEND}"

src_prepare(){
	DOCS="AUTHORS"
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	default
	vala_src_prepare
}

src_configure(){
	local emesonargs=(
		-Denable-appindicator=$(usex appindicator true false)
	)
	meson_src_configure
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

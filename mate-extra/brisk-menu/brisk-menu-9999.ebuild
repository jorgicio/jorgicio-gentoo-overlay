# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils meson

DESCRIPTION="Solus Project's Brisk Menu MATE Panel Applet"
HOMEPAGE="https://github.com/solus-project/brisk-menu"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${PN}-v${PV}.tar.xz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-2 CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND="
	>=x11-libs/gtk+-3.18:3
	>=mate-base/mate-panel-1.16.0
	dev-libs/glib:2
	dev-perl/XML-Parser
	dev-util/intltool
	gnome-base/dconf
	sys-devel/gettext
	x11-libs/libnotify
"
RDEPEND="${DEPEND}"

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

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 gnome2-utils xdg-utils

DESCRIPTION="Unofficial Whatsapp Linux client desktop application"
HOMEPAGE="https://github.com/eneshecan/whatsapp-for-linux"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-cpp/gtkmm:3.0
	net-libs/webkit-gtk:4="
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "/Version/d" resource/desktop/${PN}.desktop
	cmake_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

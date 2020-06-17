# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.28

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Native GTK+3 Twitter client, forked from Corebird"
HOMEPAGE="https://ibboard.co.uk/cawbird/"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/IBBoard/${PN}"
else
	SRC_URI="https://github.com/IBBoard/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="debug +gstreamer spellcheck"

RDEPEND="dev-db/sqlite:3
	>=dev-libs/glib-2.44:2
	dev-libs/json-glib
	gstreamer? ( media-plugins/gst-plugins-meta:1.0[X]
		media-libs/gst-plugins-base:1.0[X]
		>=media-libs/gst-plugins-bad-1.6:1.0[X]
		media-libs/gst-plugins-good:1.0
		media-plugins/gst-plugins-libav:1.0
		media-plugins/gst-plugins-soup:1.0
		media-plugins/gst-plugins-hls:1.0 )
	spellcheck? ( >=app-text/gspell-1.2 )
	>=net-libs/libsoup-2.42.3.1
	>=net-libs/rest-0.7.91:0.7
	>=x11-libs/gtk+-3.22:3"
DEPEND="
	${RDEPEND}
	$(vala_depend)
	>=dev-util/intltool-0.40
	sys-apps/sed
	virtual/pkgconfig"

pkg_setup() {
	export VALAC=valac-$(vala_best_api_version)
}

src_configure() {
	local emesonargs=(
		$(meson_use gstreamer "video")
		$(meson_use spellcheck)
	)
	meson_src_configure
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

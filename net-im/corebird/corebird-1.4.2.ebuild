# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
VALA_MIN_API_VERSION=0.28
VALA_USE_DEPEND="vapigen"

inherit eutils autotools gnome2 vala

DESCRIPTION="Native GTK+3 Twitter client"
HOMEPAGE="http://corebird.baedert.org/"
SRC_URI="https://github.com/baedert/corebird/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug gstreamer spell"

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.44:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	gstreamer? (
		media-plugins/gst-plugins-meta:1.0[X,ffmpeg]
		media-plugins/gst-plugins-hls:1.0
	)
	>=net-libs/libsoup-2.42.3.1
	>=net-libs/rest-0.7.93:0.7
	>=x11-libs/gtk+-3.18:3
	>=sys-devel/gettext-0.19.0
	net-libs/libsoup:2.4
"
DEPEND="${RDEPEND}
	$(vala_depend)
	spell? ( >=app-text/gspell-1.0[vala] )
	>=dev-util/intltool-0.40
	sys-apps/sed
	virtual/pkgconfig
"

src_prepare() {
	export VALAC="$(type -p valac-$(vala_best_api_version))"
	eautoreconf
	gnome2_src_prepare
	vala_src_prepare	
}

src_configure() {
	local myeconfargs=(
		$(usex gstreamer "" --disable-video)
		$(usex spell "" --disable-spellcheck)
		--disable-gst-check
		VALAC="$(type -p valac-$(vala_best_api_version))"
	)
	gnome2_src_configure "${myeconfargs[@]}"
}

src_compile(){
	emake VALAC="$(type -p valac-$(vala_best_api_version))"
}

src_install(){
	emake DESTDIR="${D}" install
}

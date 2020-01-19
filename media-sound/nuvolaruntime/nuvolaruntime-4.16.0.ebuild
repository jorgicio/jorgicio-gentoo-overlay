# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="threads(+)"
VALA_MIN_API_VERSION="0.42"

inherit gnome2-utils python-any-r1 vala waf-utils

DESCRIPTION="Cloud music integration for your Linux desktop"
HOMEPAGE="https://nuvola.tiliado.eu"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/tiliado/nuvolaruntime"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/tiliado/nuvolaruntime/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="debug mse"

DEPEND="
	$(vala_depend)
	${PYTHON_DEPS}
	dev-util/intltool
	>=media-libs/diorite-4.7.0
	x11-libs/libdri2
	x11-libs/libdrm
"
RDEPEND="${DEPEND}
	x11-libs/gtk+:3
	dev-libs/libgee:0.8
	dev-libs/json-glib
	net-libs/webkit-gtk:4/37[gstreamer]
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-ugly:1.0
	dev-libs/libunique:3
	>=net-libs/libsoup-2.34:2.4
	x11-libs/gdk-pixbuf[jpeg]
"

pkg_setup() {
	QA_SONAME="
		/usr/$(get_libdir)/libengineio.so
		/usr/$(get_libdir)/libnuvolaruntime-base.so
		/usr/$(get_libdir)/libnuvolaruntime-runner.so"
	python-any-r1_pkg_setup
}

src_prepare(){
	default_src_prepare
	vala_src_prepare --ignore-use
}

src_configure(){
	local myconf=()
	use !debug && myconf+=( --no-debug-symbols )
	use mse && myconf+=( --webkitgtk-supports-mse )
	waf-utils_src_configure \
		--no-unity \
		--no-appindicator \
		--no-vala-lint \
		--no-js-lint \
		--no-cef \
		"${myconf[@]}"
}

pkg_postinst(){
	gnome2_icon_cache_update
	echo
	elog "Thanks for installing Nuvola Player."
	elog "You can add plugins by installing nuvolasdk first and then"
	elog "the apps you want."
	elog "Some of the apps supported: Deezer, Spotify, YouTube, Tidal, etc."
	echo
}

pkg_postrm(){
	gnome2_icon_cache_update
}

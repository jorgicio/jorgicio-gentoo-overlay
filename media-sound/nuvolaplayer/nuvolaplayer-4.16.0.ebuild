# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="threads(+)"
VALA_MIN_API_VERSION="0.42"

inherit gnome2-utils python-any-r1 vala waf-utils

DESCRIPTION="Cloud music integration for your Linux desktop"
HOMEPAGE="https://nuvola.tiliado.eu https://launchpad.net/nuvola-player"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/tiliado/nuvolaruntime"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/tiliado/nuvolaruntime/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/nuvolaruntime-${PV}"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="appindicator debug"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	$(vala_depend)
	${PYTHON_DEPS}
	dev-util/intltool
	>=media-libs/diorite-4.7.0
	media-libs/libdri2
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
	appindicator? ( dev-libs/libappindicator:3 )
"

pkg_setup(){
	python-any-r1_pkg_setup
}

src_prepare(){
	default_src_prepare
	vala_src_prepare --ignore-use
}

src_configure(){
	local myconf=()
	use !appindicator && myconf+=( --no-appindicator )
	use !debug && myconf+=( --no-debug-symbols )
	waf-utils_src_configure \
		--no-unity \
		"${myconf[@]}"
}

pkg_postinst(){
	gnome2_icon_cache_update
}

pkg_postrm(){
	gnome2_icon_cache_update
}

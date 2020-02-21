# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7,8} )

inherit python-r1 eutils gnome2-utils xdg-utils

DESCRIPTION="Fast and minimalist music player"
HOMEPAGE="http://github.com/jendrikseipp/pogo"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="pulseaudio gnome"

DEPEND="
	${PYTHON_DEPS}
	>=x11-libs/gtk+-3.0:3
	>=media-libs/gstreamer-1.0:1.0
	media-libs/mutagen[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	x11-libs/libnotify
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-ugly:1.0
	media-plugins/gst-plugins-libav:1.0
	pulseaudio? ( media-sound/pulseaudio[equalizer] )
	gnome? ( gnome-base/gnome-settings-daemon )
"

src_install(){
	emake DESTDIR="${D}" install
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

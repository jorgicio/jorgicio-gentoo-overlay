# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit eutils gnome2 multilib python-r1 autotools

DESCRIPTION="A simple audiofile converter application for the GNOME environment"
HOMEPAGE="http://soundconverter.org/"
SRC_URI="https://github.com/kassoulet/${PN}/archive/${PV//_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="aac flac mp3 opus vorbis"

RDEPEND="${PYTHON_DEPS}
	gnome-base/gconf:2
	dev-python/gst-python:1.0[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3
	x11-libs/libnotify
	media-plugins/gst-plugins-libav
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-ugly:1.0
	media-plugins/gst-plugins-faac:1.0
	media-plugins/gst-plugins-faad:1.0
	media-plugins/gst-plugins-flac:1.0
	media-plugins/gst-plugins-lame:1.0
	media-plugins/gst-plugins-mad:1.0
	media-plugins/gst-plugins-taglib:1.0
	media-plugins/gst-plugins-opus:1.0
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
"

S="${WORKDIR}/${PN}-${PV//_/-}"

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
}

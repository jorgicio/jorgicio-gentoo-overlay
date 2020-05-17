# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

MY_PN="${PN}-player"

DESCRIPTION="Small, clear and fast Qt-based audio player"
HOMEPAGE="https://sayonara-player.com"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/luciocarreras/${MY_PN}"
else
	SRC_URI="https://sayonara-player.com/sw/${MY_PN}-${PV/_p/-stable}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_PN}"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtsql:5
	dev-qt/qtxml:5
	media-libs/taglib
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
	media-plugins/gst-plugins-soundtouch:1.0
	media-libs/libmtp
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-qt/qttest:5 )"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_TESTS="$(usex test)"
	)
	cmake_src_configure
}

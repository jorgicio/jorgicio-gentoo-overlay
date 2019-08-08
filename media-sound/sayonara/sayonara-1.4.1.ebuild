# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg-utils

DESCRIPTION="Small, clear and fast Qt-based audio player"
HOMEPAGE="https://sayonara-player.com"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sayonara-player.com/${PN}.git"
else
	MY_PN="${PN}-player"
	SRC_URI="https://sayonara-player.com/sw/${MY_PN}-${PV}-stable1.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${MY_PN}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="test"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	media-libs/taglib
	media-libs/gst-plugins-base
	media-libs/gst-plugins-good
	media-libs/gst-plugins-bad
	media-libs/libmtp
	sys-libs/zlib
	test? ( dev-qt/qttest )
"
RDEPEND="${DEPEND}"

src_configure() {
	local lib_suffix="$(get_libdir)"
	local mycmakeargs=(
		-DWITH_TESTS="$(usex test)"
		-DLIB_SUFFIX=${lib_suffix//lib}
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

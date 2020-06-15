# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MAKEFILE_GENERATOR=ninja

inherit cmake-utils git-r3

MSGPACK_VERSION="3.2.0"

DESCRIPTION="Neovim client library and GUI, in Qt5"
HOMEPAGE="https://github.com/equalsraf/neovim-qt"
EGIT_REPO_URI="${HOMEPAGE}"
SRC_URI="!msgpack? ( https://github.com/msgpack/msgpack-c/archive/cpp-${MSGPACK_VERSION}.tar.gz -> ${PN}-msgpack-${MSGPACK_VERSION}.tar.gz )"

LICENSE="ISC"
SLOT="0"
IUSE="gcov +msgpack"

DEPEND="
	msgpack? ( dev-libs/msgpack )
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}
	app-editors/neovim"

src_prepare() {
	if ! use msgpack; then
		eapply "${FILESDIR}/${PN}-0.2.16-bundled-msgpack.patch"
		cp "${DISTDIR}/${PN}-msgpack-${MSGPACK_VERSION}.tar.gz" "${S}/third-party/msgpack-${MSGPACK_VERSION}.tar.gz"
	fi
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_GCOV=$(usex gcov)
		-DUSE_SYSTEM_MSGPACK=$(usex msgpack)
	)
	cmake-utils_src_configure
}

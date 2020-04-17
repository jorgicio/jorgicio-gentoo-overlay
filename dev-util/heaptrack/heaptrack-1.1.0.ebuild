# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="Fast heap memory profiler"
HOMEPAGE="http://milianw.de/blog/heaptrack-a-heap-memory-profiler-for-linux"
SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gui test zstd"

BDEPEND="
	gui? ( kde-frameworks/extra-cmake-modules:5 )"

DEPEND="
	dev-cpp/sparsehash
	dev-libs/boost:=
	sys-libs/libunwind
	sys-libs/zlib
	gui? (
		dev-libs/kdiagram:5
		kde-frameworks/kconfig:5
		kde-frameworks/kconfigwidgets:5
		kde-frameworks/kcoreaddons:5
		kde-frameworks/ki18n:5
		kde-frameworks/kio:5
		kde-frameworks/kitemmodels:5
		kde-frameworks/kwidgetsaddons:5
		kde-frameworks/threadweaver:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
	zstd? ( app-arch/zstd:= )
"
RDEPEND="${DEPEND}
	gui? ( kde-frameworks/kf-env:5 )
"

RESTRICT+=" !test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DHEAPTRACK_BUILD_GUI=$(usex gui)
		-DBUILD_TESTING=$(usex test)
		$(cmake_use_find_package zstd Zstd)
	)
	ecm_src_configure
}

pkg_postinst() {
	use gui && ecm_pkg_postinst
}

pkg_postrm() {
	use gui && ecm_pkg_postrm
}

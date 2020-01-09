# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5 xdg-utils

DESCRIPTION="Fast heap memory profiler"
HOMEPAGE="http://milianw.de/blog/heaptrack-a-heap-memory-profiler-for-linux"
SRC_URI="https://download.kde.org/stable/${PN}/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gui test zstd"

BDEPEND="
	gui? ( $(add_frameworks_dep extra-cmake-modules) )
"
DEPEND="
	dev-cpp/sparsehash
	dev-libs/boost:=
	sys-libs/libunwind
	sys-libs/zlib
	gui? (
		dev-libs/kdiagram:5
		$(add_frameworks_dep kconfig)
		$(add_frameworks_dep kconfigwidgets)
		$(add_frameworks_dep kcoreaddons)
		$(add_frameworks_dep ki18n)
		$(add_frameworks_dep kio)
		$(add_frameworks_dep kitemmodels)
		$(add_frameworks_dep kwidgetsaddons)
		$(add_frameworks_dep threadweaver)
		$(add_qt_dep qtcore)
		$(add_qt_dep qtgui)
		$(add_qt_dep qtwidgets)
	)
	zstd? ( app-arch/zstd:= )
"
RDEPEND="${DEPEND}
	gui? ( $(add_frameworks_dep kf-env) )
"

RESTRICT+=" !test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DHEAPTRACK_BUILD_GUI=$(usex gui)
		-DBUILD_TESTING=$(usex test)
		$(cmake_use_find_package zstd Zstd)
	)
	cmake_src_configure
}

xdg_pkg_postinst() {
	if use gui; then
		xdg_desktop_database_update
		xdg_icon_cache_update
	fi
}

xdg_pkg_postrm() {
	if use gui; then
		xdg_desktop_database_update
		xdg_icon_cache_update
	fi
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5 git-r3

DESCRIPTION="Icon preview designed for Plasma"
HOMEPAGE="https://invent.kde.org/KDE/ikona"
EGIT_REPO_URI="https://invent.kde.org/kde/${PN}"

LICENSE="GPL-2"

DEPEND="
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kirigami)
	$(add_frameworks_dep plasma)
	$(add_qt_dep qtcore)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtquickcontrols2)
	$(add_qt_dep qtwebengine)"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
	dev-util/patchelf
	$(add_frameworks_dep extra-cmake-modules)
	virtual/rust"

src_install() {
	kde5_src_install
	# little tweak
	mv "${ED}/usr/etc" "${ED}"/
	patchelf --remove-rpath "${ED}/usr/bin/${PN}-cli"
	patchelf --remove-rpath "${ED}/usr/$(get_libdir)/libikonars.so"
}

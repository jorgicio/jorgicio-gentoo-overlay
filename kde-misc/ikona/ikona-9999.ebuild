# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm git-r3 kde.org

DESCRIPTION="Icon preview designed for Plasma"
HOMEPAGE="https://invent.kde.org/KDE/ikona"
EGIT_REPO_URI="https://invent.kde.org/kde/${PN}"

LICENSE="GPL-2"
SLOT="5"

DEPEND="
	kde-frameworks/ki18n:5
	kde-frameworks/kirigami:5
	kde-frameworks/plasma:5
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwebengine:5"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
	dev-util/patchelf
	kde-frameworks/extra-cmake-modules:5
	virtual/rust"

src_install() {
	ecm_src_install
	# little tweak
	mv "${ED}/usr/etc" "${ED}"/
	patchelf --remove-rpath "${ED}/usr/bin/${PN}-cli"
	patchelf --remove-rpath "${ED}/usr/$(get_libdir)/libikonars.so"
}

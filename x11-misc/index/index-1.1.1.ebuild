# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_QTHELP="true"
KFMIN=5.60.0
QTMIN=5.12.3

inherit ecm kde.org

MY_PN="${PN}-fm"
MY_P="${MY_PN}-v${PV}"

DESCRIPTION="File manager that works on desktops, Android and Plasma Mobile"
HOMEPAGE="https://invent.kde.org/maui/index-fm"
SRC_URI="https://invent.kde.org/maui/${MY_PN}/-/archive/v${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="
	>=dev-libs/mauikit-1.0.0:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
	dev-qt/qmltermwidget
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5"
RDEPEND="${DEPEND}"
BDEPEND=">=kde-frameworks/extra-cmake-modules-${KFMIN}:5"

S="${WORKDIR}/${MY_P}"

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="Plasma 5 widget that gives access to user places"
HOMEPAGE="https://github.com/dfaust/plasma-applet-places-widget"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-2"
SLOT="5"

DEPEND="
	kde-frameworks/extra-cmake-modules:5
	kde-plasma/plasma-workspace:5
"
RDEPEND="${DEPEND}"

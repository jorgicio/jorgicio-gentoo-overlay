# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

DESCRIPTION="Plasma 5 widget that gives access to user places"
HOMEPAGE="https://github.com/dfaust/plasma-applet-places-widget"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

IUSE=""

DEPEND="
	$(add_frameworks_dep extra-cmake-modules)
	$(add_plasma_dep plasma-workspace)
"
RDEPEND="${DEPEND}"

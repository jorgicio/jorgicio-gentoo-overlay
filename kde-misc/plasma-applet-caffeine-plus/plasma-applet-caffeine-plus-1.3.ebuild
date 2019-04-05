# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

DESCRIPTION="Plasma 5 applet to disable screensaver and auto-suspend"
HOMEPAGE="https://github.com/qunxyz/plasma-applet-caffeine-plus"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-2"
IUSE=""

DEPEND="
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep extra-cmake-modules)
	$(add_frameworks_dep kio)
	$(add_qt_dep qtquickcontrols2)
	$(add_qt_dep qtcore)
"
RDEPEND="${DEPEND}"

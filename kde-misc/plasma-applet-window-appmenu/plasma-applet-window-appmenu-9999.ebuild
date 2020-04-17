# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PLASMA_MINIMAL="5.12"
QT_MINIMAL="5.9"
FRAMEWORKS_MINIMAL="5.38"
inherit ecm kde.org

MY_PN="${PN/plasma-}"

DESCRIPTION="Plasma 5 applet in order to show the window appmenu"
HOMEPAGE="https://store.kde.org/p/1274975"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/psifidotos/${MY_PN}.git"
else
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/psifidotos/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2"
SLOT="5"

DEPEND="
	>=kde-frameworks/plasma-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/frameworkintegration-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qdbus-${QT_MINIMAL}:5
	x11-libs/libxcb
"
RDEPEND="${DEPEND}"

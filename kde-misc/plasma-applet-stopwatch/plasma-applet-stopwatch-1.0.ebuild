# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

MY_PN="StopWatchPlasmoid"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Plasma 5 applet to add a stopwatch"
HOMEPAGE="https://www.opendesktop.org/p/1172307"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1488978022/s/a4197810b3721b97e57eb32f0c54dc5dc11f76f49ac352ec8ea2f42047b08a166027856a60fd13fe9f7fbd6fea829608e36c8bbbf17ee2132fcd13c805c2d28c/t/1554691799/u//${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SLOT="5"
LICENSE="GPL-2"

DEPEND="
	kde-frameworks/plasma:5
	kde-frameworks/extra-cmake-modules:5
"
RDEPEND="${DEPEND}"

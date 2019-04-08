# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

MY_PN="StopWatchPlasmoid"

DESCRIPTION="Plasma 5 applet to add a stopwatch"
HOMEPAGE="https://www.opendesktop.org/p/1172307"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1488978022/s/a4197810b3721b97e57eb32f0c54dc5dc11f76f49ac352ec8ea2f42047b08a166027856a60fd13fe9f7fbd6fea829608e36c8bbbf17ee2132fcd13c805c2d28c/t/1554691799/u//${MY_PN}-${PV}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep extra-cmake-modules)
"
RDEPEND="${DEPEND}"

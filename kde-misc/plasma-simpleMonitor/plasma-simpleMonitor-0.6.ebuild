# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

DESCRIPTION="Plasma 5 simple and compact system monitor"
HOMEPAGE="https://store.kde.org/p/1173509"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/dhabyx/${PN}.git"
else
	SRC_URI="https://github.com/dhabyx/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
IUSE=""

DEPEND="
	$(add_frameworks_dep extra-cmake-modules)
	$(add_frameworks_dep plasma)
"
RDEPEND="${DEPEND}"

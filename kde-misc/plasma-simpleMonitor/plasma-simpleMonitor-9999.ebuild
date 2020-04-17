# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="Plasma 5 simple and compact system monitor"
HOMEPAGE="https://store.kde.org/p/1173509"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dhabyx/${PN}.git"
else
	SRC_URI="https://github.com/dhabyx/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="5"

DEPEND="
	kde-frameworks/extra-cmake-modules:5
	kde-frameworks/plasma:5
"
RDEPEND="${DEPEND}"

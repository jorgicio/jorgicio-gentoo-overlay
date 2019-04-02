# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="SDK for Nuvola suite, including the Nuvola Player/Runtime and plugins"
HOMEPAGE="https://github.com/tiliado/nuvolasdk"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="${HOMEPAGE}/archive/${PV}/${P}.tar.gz"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	media-gfx/imagemagick
	media-gfx/scour
	"
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

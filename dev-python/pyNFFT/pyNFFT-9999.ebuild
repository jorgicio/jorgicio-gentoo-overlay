# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6}} )
inherit distutils-r1

DESCRIPTION="A pythonic wrapper around the NFFT library"
HOMEPAGE="https://github.com/pyNFFT/pyNFFT"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="openmp"

DEPEND="
	>=dev-python/numpy-1.6.0[${PYTHON_USEDEP}]
	sci-libs/nfft[openmp?]"
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

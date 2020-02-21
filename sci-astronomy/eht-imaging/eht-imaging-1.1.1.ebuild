# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Imaging, analysis, and simulation software for radio interferometry"
HOMEPAGE="https://achael.github.io/eht-imaging"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/achael/${PN}.git"
else
	SRC_URI="https://github.com/achael/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="dynamical nfft pandas"

DEPEND="
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/networkx[pandas?,${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-astronomy/pyephem[${PYTHON_USEDEP}]
	sci-libs/scikits_image[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dynamical? (
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/HTML[${PYTHON_USEDEP}]
	)
	nfft? ( dev-python/pyNFFT[${PYTHON_USEDEP}] )
	pandas? ( dev-python/pandas[${PYTHON_USEDEP}] )
"
BDEPEND="${PYTHON_DEPS}"

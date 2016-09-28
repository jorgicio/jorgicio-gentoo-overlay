# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Convert scans of handwritten notes into beautiful, compact PDFs"
HOMEPAGE="https://mzucker.github.io/2016/09/20/noteshrink.html"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mzucker/noteshrink"
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/n/${PN}/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPEND}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="Small GUI wrapper for ffmpeg based on PyQt5"
HOMEPAGE="https://videomorph.webmisolutions.com"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/videomorph-dev/${PN}.git"
else
	SRC_URI="https://videomorph.webmisolutions.com/download/${P}-src.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-python/PyQt5[${PYTHON_USEDEP}]
	virtual/ffmpeg
"
RDEPEND="${DEPEND}"

# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1

DESCRIPTION="Small GUI wrapper for ffmpeg based on PyQt5"
HOMEPAGE="https://videomorph.webmisolutions.com"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/videomorph-dev/${PN}.git"
else
	SRC_URI="https://github.com/videomorph-dev/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	${PYTHON_DEPS}
	dev-python/PyQt5[${PYTHON_USEDEP}]
	virtual/ffmpeg
"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i -e 's/changelog.gz/changelog/' setup.py
	sed -i -e 's/videomorph.1.gz/videomorph.1/' setup.py
	distutils-r1_src_prepare
}

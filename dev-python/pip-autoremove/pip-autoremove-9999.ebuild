# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Utility to remove a pip-installed package and its unused dependencies"
HOMEPAGE="https://github.com/invl/pip-autoremove"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPENDS}"
RDEPEND="${DEPEND}
	dev-python/pip
"

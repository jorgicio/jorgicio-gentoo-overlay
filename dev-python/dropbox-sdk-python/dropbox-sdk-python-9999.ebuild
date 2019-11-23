# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )
inherit distutils-r1 git-r3

DESCRIPTION="Python SDK for Dropbox Core APIs"
HOMEPAGE="https://www.dropbox.com/developers/core/sdks/python"
SRC_URI=""
EGIT_REPO_URI="https://github.com/dropbox/${PN}.git"

if [[ ${PV} == 9999 ]];then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="v${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-python/setuptools-38[${PYTHON_USEDEP}]
	dev-python/requests[ssl,${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

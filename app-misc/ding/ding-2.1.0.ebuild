# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6,7,8}} )

inherit distutils-r1

DESCRIPTION="A very simple cli-based solution with short-term time managment"
HOMEPAGE="https://github.com/liviu-/ding"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	MY_PN="${PN}-${PN}"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="mirror://pypi/d/${MY_PN}/${MY_P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="MIT"
SLOT="0"

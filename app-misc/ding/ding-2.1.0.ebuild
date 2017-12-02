# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )

inherit distutils-r1

DESCRIPTION="A very simple cli-based solution with short-term time managment"
HOMEPAGE="https://github.com/liviu-/ding"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	MY_PN="${PN}-${PN}"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="mirror://pypi/d/${MY_PN}/${MY_P}.tar.gz"
	KEYWORDS="x86 amd64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

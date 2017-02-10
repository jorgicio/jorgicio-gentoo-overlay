# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5}} pypy )

inherit distutils-r1

DESCRIPTION="A safe alterantive for the rm command with some differences"
HOMEPAGE="https://github.com/alanzchen/rm-protection"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~x86-linux ~x86-fbsd ~amd64-fbsd ~arm ~arm-linux ~arm64 ~amd64-linux ~ppc ~ppc64 ~mips ~hppa ~ia64 ~sparc"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	sys-apps/util-linux[python]"

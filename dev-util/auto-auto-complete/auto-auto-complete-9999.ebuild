# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-any-r1

DESCRIPTION="Autogenerate shell auto-completion scripts"
HOMEPAGE="https://github.com/maandree/auto-auto-complete"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="sys-apps/texinfo"
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

pkg_setup(){
	python-any-r1_pkg_setup
}

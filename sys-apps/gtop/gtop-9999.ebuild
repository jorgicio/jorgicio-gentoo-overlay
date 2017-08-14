# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="System monitoring dashboard for terminal"
HOMEPAGE="https://github.com/aksakalli/gtop"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=net-libs/nodejs-4.0[npm]"
RDEPEND="${DEPEND}"

src_install(){
	npm install -g --prefix="${D}/usr" ${PN} || die "${PN} could not be installed"
}

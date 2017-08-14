# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A cross-platform tool to fabulously kill processes"
HOMEPAGE="https://github.com/sindresorhus/fkill-cli"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=net-libs/nodejs-4.0[npm]"
RDEPEND="${DEPEND}"

src_install(){
	npm install -g --prefix="${D}/usr" ${PN} || die
}

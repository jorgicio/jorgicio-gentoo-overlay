# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Find relevant emoji from text on the command line"
HOMEPAGE="https://github.com/sindresorhus/emoj"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	RESTRICT="mirror"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	>=net-libs/nodejs-4.0.0[npm]
	|| ( 
		media-fonts/emojione-color-font[X]
		media-fonts/twemoji-color-font[X]
	)
"
RDEPEND="${DEPEND}"

src_install(){
	npm install -g --prefix="${D}/usr" ${PN}@${PV} || die
}

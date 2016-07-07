# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils

DESCRIPTION="Generates a table of contents for Markdown files inside for a git-based repository"
HOMEPAGE="https://github.com/thlorenz/doctoc"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
	RESTRICT="mirror"
fi

LICENSE="LGPL-3.0"
SLOT="0"
IUSE=""

DEPEND="net-libs/nodejs[npm]"
RDEPEND="${DEPEND}"

src_install(){
	npm install -g --prefix="${D}/usr" ${PN} || die "Installation failed"
}

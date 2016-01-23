# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Generates a table of contents for Markdown files inside for a git-based repository"
HOMEPAGE="https://github.com/thlorenz/${PN}"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-libs/nodejs[npm]"
RDEPEND="${DEPEND}"

src_install(){
	npm install -g --prefix="${D}/usr" ${PN} || die "Installation failed"
}

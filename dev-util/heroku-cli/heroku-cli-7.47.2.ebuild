# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-cli}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A tool for creating and managing Heroku apps from the command line"
HOMEPAGE="https://devcenter.heroku.com/articles/heroku-cli"
SRC_URI="https://registry.npmjs.org/${MY_PN}/-/${MY_P}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="network-sandbox strip"

RDEPEND="dev-vcs/git"
BDEPEND="net-libs/nodejs[npm]"

S="${DISTDIR}"

# Don't unpack
src_unpack(){
	true
}

src_install(){
	npm install -g --user root --prefix "${D}/usr" "${MY_P}.tgz" || die
	find "${D}/usr" -type d -exec chmod 755 '{}' +
}

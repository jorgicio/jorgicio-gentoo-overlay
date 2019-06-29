# Copyright 1999-2019 Gentoo Foundation
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
IUSE="+git"
RESTRICT="network-sandbox strip"

RDEPEND="git? ( dev-vcs/git )"
BDEPEND="net-libs/nodejs[npm]"

S="${WORKDIR}"

# Don't unpack
src_unpack(){
	einfo "Not unpacking \"${DISTDIR}/${MY_P}.tgz\"; continue..."
}

src_install(){
	npm install -g --user root --prefix "${D}/usr" "${DISTDIR}/${MY_P}.tgz" || die
	dosym "/usr/$(get_libdir)/node_modules/${MY_PN}/LICENSE" "/usr/share/licenses/${PN}/LICENSE"
	find "${D}/usr" -type d -exec chmod 755 '{}' +
}

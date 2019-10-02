# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="create-react-app"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Declarative, efficient and flexible JavaScript library to build user interfaces."
HOMEPAGE="https://reactjs.org"
SRC_URI="https://registry.npmjs.org/${MY_PN}/-/${MY_P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="network-sandbox strip"

BDEPEND="net-libs/nodejs[npm]"

S="${DISTDIR}"

# Don't unpack
src_unpack() {
	true
}

src_install() {
	npm install -g --user root --prefix "${D}/usr" "${MY_P}.tgz" || die
}

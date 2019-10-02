# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Development platform for building mobile and desktop web apps"
HOMEPAGE="https://angular.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="network-sandbox strip"

BDEPEND="net-libs/nodejs[npm]"

S="${WORKDIR}"

# Nothing to unpack
src_unpack() {
	true
}

src_install() {
	npm install -g --user root --prefix "${D}/usr" "@${PN}/cli@${PV}" || die
}

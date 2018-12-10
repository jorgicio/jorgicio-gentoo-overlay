# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A tool for creating and managing Heroku apps from the command line"
HOMEPAGE="https://devcenter.heroku.com/articles/heroku-cli"
SRC_URI="https://registry.npmjs.org/heroku/-/heroku-${PV}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+git"
RESTRICT="strip"

DEPEND="
	net-libs/nodejs[npm]
"
RDEPEND="${DEPEND}
	git? ( dev-vcs/git )"


S="${WORKDIR}/package"

src_install(){
	npm install -g --user root --prefix "${D}/usr" "${DISTDIR}/heroku-${PV}.tgz"
	dosym "/usr/$(get_libdir)/node_modules/heroku/LICENSE" "/usr/share/licenses/${PN}/LICENSE"
	find "${D}/usr" -type d -exec chmod 755 '{}' +
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A tool for creating and managing Heroku apps from the command line"
HOMEPAGE="https://devcenter.heroku.com/articles/heroku-cli"
HEROKU_HASH="3dce47c"
BASE_URI="https://cli-assets.heroku.com/${PN}/channels/stable"
SRC_URI="
	x86? ( ${BASE_URI}/${PN}-v${PV}-${HEROKU_HASH}-linux-x86.tar.gz -> ${P}-x86.tar.gz )
	amd64? ( ${BASE_URI}/${PN}-v${PV}-${HEROKU_HASH}-linux-x64.tar.gz -> ${P}-x64.tar.gz )
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+git +system-node"

DEPEND="
	git? ( dev-vcs/git )
	system-node? ( dev-libs/nodejs[npm] )
"
RDEPEND="${DEPEND}"

pkg_setup(){
	use amd64 && ARCH="x64"
	use x86 && ARCH="x86"
	S="${WORKDIR}/${PN}-v${PV}-${HEROKU_HASH}-linux-${ARCH}"
}

src_prepare(){
	if use system-node; then
		rm bin/node
		sed -i "s#\"\$DIR/node\"#\$\(which node\)#" bin/heroku
	fi
	default
}

src_install(){
	insinto /opt/${PN}
	doins -r *
	fperms +x /opt/${PN}/bin/${PN//-cli}
	use !system-node && fperms +x /opt/${PN}/bin/node
	insinto /usr/share/licenses/${PN}
	doins LICENSE
	dosym /opt/${PN}/bin/${PN//-cli} /usr/bin/${PN}
}

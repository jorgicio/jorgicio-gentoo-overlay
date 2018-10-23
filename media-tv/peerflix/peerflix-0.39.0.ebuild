# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Streaming torrent client for node.js"
HOMEPAGE="https://github.com/mafintosh/peerflix"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
	SRC_URI=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="net-libs/nodejs[npm]"
DEPEND="${RDEPEND}"

src_install() {
	npm install -g --prefix "${D}/usr" || die "Failed installation"
}

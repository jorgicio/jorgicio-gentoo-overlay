# Copyright 2014-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Streaming torrent client for node.js"
HOMEPAGE="https://github.com/mafintosh/peerflix"
SRC_URI="https://github.com/mafintosh/peerflix/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-libs/nodejs[npm]"
DEPEND="${RDEPEND}"

src_install() {
  npm install -g --prefix "${D}/usr" || die "Failed installation"
}

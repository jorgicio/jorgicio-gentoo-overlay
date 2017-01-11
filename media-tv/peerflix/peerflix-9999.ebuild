# Copyright 2014-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit git-r3

DESCRIPTION="Streaming torrent client for node.js"
HOMEPAGE="https://github.com/mafintosh/peerflix"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="net-libs/nodejs[npm]"
DEPEND="${RDEPEND}"

src_install() {
  npm install -g --prefix "${D}/usr" || die "Failed installation"
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo git-r3

DESCRIPTION="ripgrep, but also search in PDFs, e-books, office documents, compressed, etc."
HOMEPAGE="https://github.com/phiresky/ripgrep-all"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="AGPL-3"
SLOT="0"

RDEPEND="
	app-text/pandoc
	app-text/poppler
	sys-apps/ripgrep
	media-video/ffmpeg
"
DEPEND="${RDEPEND}"
RESTRICT="network-sandbox"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

pkg_postinst(){
	echo
	elog "In order to use ripgrep-all, use the rga command."
	elog "You can also use the preprocessor using the command"
	elog "rga-preproc."
	echo
}

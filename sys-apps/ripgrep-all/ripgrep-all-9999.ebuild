# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo git-r3

CARGO_FETCH_CRATES=yes

DESCRIPTION="ripgrep, but also search in PDFs, e-books, office documents, compressed, etc."
HOMEPAGE="https://github.com/phiresky/ripgrep-all"
SRC_URI="$(cargo_crate_uris ${CRATES})"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="AGPL-3"
SLOT="0"

RDEPEND="
	app-text/pandoc
	app-text/poppler
	sys-apps/ripgrep
	virtual/ffmpeg
"
DEPEND="${RDEPEND}"
RESTRICT="network-sandbox"

pkg_postinst(){
	echo
	elog "In order to use ripgrep-all, use the rga command."
	elog "You can also use the preprocessor using the command"
	elog "rga-preproc."
	echo
}

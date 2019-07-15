# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Asynchronous email client for your terminal, written in Go."
HOMEPAGE="https://aerc-mail.org"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/${PN}"
else
	SRC_URI="https://git.sr.ht/~sircmpwn/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

RESTRICT="network-sandbox"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	app-text/scdoc
	dev-vcs/git
"
RDEPEND="${DEPEND}
	|| (
		dev-libs/libvterm
		dev-libs/libvterm-neovim
	)
	dev-python/colorama
	net-proxy/dante
	|| (
		virtual/w3m
		www-client/lynx
		www-client/links
	)
"
BDEPEND=">=dev-lang/go-1.12.0"

pkg_setup(){
	# aerc uses default PREFIX=/usr/local
	export PREFIX="${EPREFIX}/usr"
}

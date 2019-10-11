# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo git-r3

CARGO_FETCH_CRATES=yes

DESCRIPTION="The cross-shell prompt for astronauts"
HOMEPAGE="https://starship.rs"
EGIT_REPO_URI="https://github.com/starship/${PN}.git"

LICENSE="ISC"
SLOT="0"

DEPEND="
	dev-libs/openssl:0
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
RESTRICT="network-sandbox"

DOCS="docs/README.md"

src_install() {
	# Can't install as a cargo package,
	# let's do this manually.
	dobin target/release/${PN}
	default
}

pkg_postinst() {
	echo
	elog "Thanks for installing starship."
	elog "For better experience, it's suggested to install some Powerline font."
	elog "You can get some from https://github.com/powerline/fonts"
	echo
}

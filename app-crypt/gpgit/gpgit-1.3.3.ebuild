# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A shell script that automates the process of signing Git sources via GPG"
HOMEPAGE="https://github.com/NicoHood/gpgit"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="${HOMEPAGE}/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="MIT"
SLOT="0"
IUSE="github lzip"

DEPEND="
	app-shells/bash
	app-crypt/gnupg
	dev-vcs/git
	app-arch/xz-utils
"
RDEPEND="${DEPEND}
	github? (
		app-misc/jq
		net-misc/curl
	)
	lzip? ( app-arch/lzip )
"

src_prepare(){
	sed -i -e "s#/doc/gpgit#/doc/${P}#g" Makefile
	default_src_prepare
}

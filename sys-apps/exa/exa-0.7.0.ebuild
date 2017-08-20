# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils bash-completion-r1

DESCRIPTION="A modern replacement for ls written in Rust"
HOMEPAGE="https://the.exa.website"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/ogham/${PN}.git"
else
	SRC_URI="https://github.com/ogham/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="zsh-completion fish-completion"

DEPEND="
	>=virtual/rust-1.17.0
	dev-libs/libgit2
	dev-util/cmake
	|| (
		>=dev-util/cargo-0.5.0
		>=dev-util/cargo-bin-0.5.0
	)
"
RDEPEND="${DEPEND}
	zsh-completion? ( app-shells/gentoo-zsh-completions )
	fish-completion? ( app-shells/fish )
"

src_prepare(){
	eapply "${FILESDIR}/${PN}-fix-features.patch"
	eapply_user
}

src_install(){
	emake DESTDIR="${D}" install
	
	newbashcomp contrib/completions.bash "${PN}"
	
	if use zsh-completion;then
		insinto /usr/share/zsh/site-functions
		newins contrib/completions.zsh "_${PN}"
	fi
	
	if use fish-completion;then
		insinto /usr/share/fish/completions
		newins contrib/completions.fish "${PN}.fish"
	fi
}

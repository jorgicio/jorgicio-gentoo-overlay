# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )

inherit bash-completion-r1 eutils python-r1

DESCRIPTION="Google Search from command line"
HOMEPAGE="https://github.com/jarun/googler"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="bash-completion fish-completion zsh-completion"

RDEPEND="${PYTHON_DEPS}"

RESTRICT="test"

src_prepare(){
	default
	sed -i \
		-e "s:^.*gzip -c.*::" \
		-e "s:googler.1.gz:googler.1:" \
		Makefile || die
}

src_install(){
	emake disable-self-upgrade
	emake DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		DOCDIR="${D}/${EPREFIX}/usr/share/doc/${PF}" \
		install
	use bash-completion && newbashcomp auto-completion/bash/${PN}-completion.bash ${PN}
	if use fish-completion; then
		insinto /usr/share/fish/vendor_completions.d/
		doins auto-completion/fish/${PN}.fish
	fi
	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		doins auto-completion/zsh/_${PN}
	fi
}

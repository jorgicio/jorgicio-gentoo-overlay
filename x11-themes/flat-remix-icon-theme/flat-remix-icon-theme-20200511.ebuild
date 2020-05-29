# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A pretty simple icon theme, derived from Ultra-Flat-Icons, Paper and Flattr"
HOMEPAGE="https://drasite.com/flat-remix"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/daniruiz/Flat-Remix.git"
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="https://github.com/daniruiz/Flat-Remix/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P//-icon-theme}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="dark light"
RESTRICT="strip"

src_install() {
	THEMES="$(echo Flat-Remix-{Blue,Green,Red,Yellow})"
	use dark && THEMES+=" $(echo Flat-Remix-{Blue,Green,Red,Yellow}-Dark)"
	use light && THEMES+=" $(echo Flat-Remix-{Blue,Green,Red,Yellow}-Light)"
	THEMES="${THEMES}" default
}

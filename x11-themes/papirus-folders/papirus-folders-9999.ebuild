# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Allows to change the color of folders for Papirus Icon Theme"
HOMEPAGE="https://git.io/papirus-folders"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/${PN}"
else
	SRC_URI="https://github.com/PapirusDevelopmentTeam/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="x11-themes/papirus-icon-theme"

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Papirus icon themes for Filezilla"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-filezilla-themes"
if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	net-ftp/filezilla"

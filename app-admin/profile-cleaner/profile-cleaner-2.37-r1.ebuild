# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Vacuum and reindex browser sqlite databases"
HOMEPAGE="https://github.com/graysky2/profile-cleaner"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/graysky2/${PN}.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/graysky2/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"

DOCS=( README.md )

RDEPEND="app-shells/bash
	sys-devel/bc
	sys-apps/coreutils
	sys-apps/findutils
	sys-apps/grep
	sys-apps/sed
	sys-process/parallel
	dev-db/sqlite:3"

PATCHES=( "${FILESDIR}/${PN}-brave-browser-support.patch" )

src_install(){
	DESTDIR="${D}" emake install-bin
	doman doc/pc.1
	newman doc/pc.1 profile-cleaner.1
	einstalldocs
}

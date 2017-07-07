# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="System76 Pop icon theme for Linux"
HOMEPAGE="http://github.com/system76/pop-icon-theme"
if [[ ${PV} == *99999999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure(){
	default
}

src_compile(){
	default
}

src_install(){
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" post-install
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Docking battery monitor and CPU governor controller, forked from trayfreq"
HOMEPAGE="http://github.com/phillid/paramano"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}
	app-admin/sudo
"

src_compile(){
	CFLAGS+=" -std=c11" emake -C "${S}" all
}

src_install(){
	emake -C "${S}" DESTDIR="${D}" install
}

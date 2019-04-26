# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Docking battery monitor and CPU governor controller, forked from trayfreq"
HOMEPAGE="https://gitlab.com/dphillips/paramano"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/gtk+:2
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

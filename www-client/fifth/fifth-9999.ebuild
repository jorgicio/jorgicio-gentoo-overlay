# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools

DESCRIPTION="Linux-exclusive Opera-like lightweight web browser"
HOMEPAGE="http://fifth-browser.sourceforge.net"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/clbr/${PN}.git"
else
	SRC_URI="mirror://sourceforge/${PN}-browser/${P}.txz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	net-libs/webkitfltk
	dev-libs/liburlmatch
	dev-games/physfs
"
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf -i
	eapply_user
}

src_install(){
	emake check
	emake DESTDIR="${D}" install
}

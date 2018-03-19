# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools flag-o-matic toolchain-funcs versionator

DESCRIPTION="Linux-exclusive Opera-like lightweight web browser"
HOMEPAGE="http://fifth-browser.sourceforge.net"

if [[ ${PV} == *9999 ]];then
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
	dev-libs/urlmatch
	dev-games/physfs
"
RDEPEND="${DEPEND}"

pkg_pretend(){
	if ! test-flag-CXX -std=c++11; then
		die "You need at least GCC 4.7.3 or Clang >= 3.3 for C++11-specific compiler flags"
	fi

	if tc-is-gcc && ! version_is_at_least 4.7.3 "$(gcc-version)"; then
		die "The active compiler needs to be gcc 4.7.3 (or newer)"
	fi
}

src_prepare(){
	eautoreconf -i
	eapply_user
}

src_install(){
	emake check
	emake DESTDIR="${D}" install
}

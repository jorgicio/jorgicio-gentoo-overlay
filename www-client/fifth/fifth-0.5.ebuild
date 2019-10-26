# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic toolchain-funcs xdg-utils

DESCRIPTION="Linux-exclusive Opera-like lightweight web browser"
HOMEPAGE="http://fifth-browser.sourceforge.net"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/clbr/${PN}.git"
else
	SRC_URI="mirror://sourceforge/${PN}-browser/${P}.txz"
	KEYWORDS="~x86 ~amd64 ~arm ~arm64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	net-libs/webkitfltk
	dev-libs/urlmatch
	dev-games/physfs
	media-libs/harfbuzz[cairo,icu]
"
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf -i
	default
}

src_configure(){
	if ! test-flag-CXX -std=c++11; then
		die "You need at least GCC 4.7.3 or Clang >= 3.3 for C++11-specific compiler flags"
	fi

	if tc-is-gcc && ! version_is_at_least 4.7.3 "$(gcc-version)" ; then
		die "The active compiler needs to be gcc 4.7.3 (or newer)"
	fi
	default
}

src_install(){
	emake check
	default
}

pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}

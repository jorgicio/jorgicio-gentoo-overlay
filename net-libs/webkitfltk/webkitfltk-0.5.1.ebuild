# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1 flag-o-matic toolchain-funcs

DESCRIPTION="Port of Webkit to FLTK 1.3"
HOMEPAGE="http://fifth-browser.sourceforge.net"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/clbr/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/fifth-browser/${P}.txz"
	KEYWORDS="~x86 ~arm ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-lang/perl
	dev-lang/ruby[ssl]
	sys-libs/zlib
	media-libs/libpng:0
	virtual/jpeg:0
	dev-libs/libxslt
	dev-libs/libxml2
	media-libs/freetype
	>=dev-libs/openssl-0.9.8k
	net-misc/curl
	dev-libs/icu
	media-libs/harfbuzz[icu]
	dev-db/sqlite:3
	>=x11-libs/fltk-1.3.3
"
RDEPEND="${DEPEND}"

pkg_pretend(){
	if ! test-flag-CXX -std=c++11; then
		die "You need at least GCC 4.7.3 or clang >= 3.3 for C++11-specific compiler flags"
	fi

	if tc-is-gcc && [[ $(gcc-version) < 4.7.3 ]]; then
		die "The active compiler needs to be 4.7.3 (or newer)"
	fi
}

#src_prepare(){
#	PATCHES=(
#		"${FILESDIR}/${PN}-1.patch"
#		"${FILESDIR}/${PN}-2.patch"
#	)
#	epatch ${PATCHES[@]}
#	eapply_user
#}

src_compile(){
	emake -C Source/bmalloc/bmalloc
	emake -C Source/WTF/wtf
	emake -C Source/JavaScriptCore gen
	emake -C Source/JavaScriptCore
	emake -C Source/WebCore
	emake -C Source/WebKit/fltk
}

src_install(){
	emake -C Source/WebKit/fltk DESTDIR="${D}" install
}

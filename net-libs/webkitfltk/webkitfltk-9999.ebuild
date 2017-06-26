# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

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

src_compile(){
	BUILDS=(
		Source/bmalloc/bmalloc
		Source/WTF/wtf
		Source/JavaScriptCore gen
		Source/JavaScriptCore
		Source/WebCore
		Source/WebKit/fltk
	)
	emake -C ${BUILDS[@]}
}

src_install(){
	emake -C Source/WebKit/fltk DESTDIR="${D}" install
}

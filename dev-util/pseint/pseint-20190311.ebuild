# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

WX_GTK_VER="3.0"

inherit wxwidgets

DESCRIPTION="A tool for learning programming basis with simple Spanish pseudocode"
HOMEPAGE="http://pseint.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/${PN}"

DEPEND="
	x11-libs/wxGTK:3.0
"
RDEPEND="
	${DEPEND}
	media-libs/libpng:1.2
	virtual/glu
"

src_prepare(){
	sed -i -e "s#unicode=no#unicode=yes#" wxPSeInt/Makefile.lnx
	sed -i -e "s#2.8#3.0#" wxPSeInt/Makefile.lnx
	sed -i -e "s#stc-2.8#stc-3.0#" wxPSeInt/Makefile.lnx
	default_src_prepare
}

src_configure(){
	setup-wxwidgets
	default_src_configure
}

src_compile(){
	emake linux
}

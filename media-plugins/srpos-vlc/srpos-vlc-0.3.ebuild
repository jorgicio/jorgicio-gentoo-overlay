# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="VLC plugin for resuming from last played position"
HOMEPAGE="http://vlcsrposplugin.sourceforge.net/"
SRC_URI="http://ufpr.dl.sourceforge.net/project/vlcsrposplugin/libsrpos_plugin-0.3.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-video/vlc"
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${A}
	mv ${WORKDIR}/libsrpos_plugin-0.3 ${WORKDIR}/${P}
}

src_compile(){
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	emake DESTDIR="${D}" install
	dodoc README
}

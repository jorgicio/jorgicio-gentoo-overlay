# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="VLC plugin for resuming from last played position"
HOMEPAGE="http://vlcsrposplugin.sourceforge.net/"
SRC_URI="mirror://sourceforge/vlcsrposplugin/libsrpos_plugin-${PV}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="<media-video/vlc-2.2.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/libsrpos_plugin-${PV}

src_compile(){
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	emake DESTDIR="${D}" install
	dodoc README
}

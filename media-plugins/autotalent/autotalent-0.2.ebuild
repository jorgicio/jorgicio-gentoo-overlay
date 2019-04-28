# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit multilib

DESCRIPTION="Realtime pitch correction plugin"
HOMEPAGE="http://tombaran.info/autotalent.html"
SRC_URI="http://tombaran.info/autotalent-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/ladspa-sdk"
RDEPEND="${DEPEND}"
DOCS=( README )

src_prepare(){
	sed -i -e "s#/usr/lib64#\${DESTDIR}/usr/$(get_libdir)#" Makefile || die
	default_src_prepare
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-r1 autotools eutils

DESCRIPTION="Python bindings for libsexy."
HOMEPAGE="http://www.chipx86.com/wiki/Libsexy"
SRC_URI="http://releases.chipx86.com/libsexy/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/pygtk-2.6.2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare(){
	eautoreconf
	epatch_user
}

src_configure(){
	econf
}

src_compile(){
	emake
}

src_install(){
	emake DESTDIR="${D}" install
}

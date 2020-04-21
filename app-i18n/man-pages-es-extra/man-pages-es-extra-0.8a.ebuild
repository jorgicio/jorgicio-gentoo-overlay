# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN/-/}-${PV}"
DESCRIPTION="A somewhat comprehensive collection of Spanish Linux man pages - Extra files"
HOMEPAGE="https://packages.debian.org/jessie/manpages-es-extra"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN/-/}/${PN/-/}_${PV}.orig.tar.gz"

LICENSE="GPL-3+ man-pages GPL-2+ GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

RDEPEND="virtual/man
	app-i18n/man-pages-es"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS=( LEEME.extra README PROYECTO )

src_prepare(){
	rm Makefile || die
	rm man1/mc.1 || die
	rm man3/{dlclose,dlerror,dlopen,dlsym}.3 || die
	rm man5/{acct,host.conf,resolv.conf,resolver}.5 || die
	rm man8/ld.so.8 || die
	default
}

src_install(){
	for i in {1..8}; do
		for j in $(ls man${i}/*.${i}); do
			doman -i18n=es ${j}
		done
	done
	einstalldocs
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN/-/}-${PV}"
DESCRIPTION="A somewhat comprehensive collection of Spanish Linux man pages"
HOMEPAGE="https://packages.debian.org/stable/manpages-es"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN/-/}/${PN/-/}_${PV}.orig.tar.gz"

LICENSE="GPL-3+ man-pages GPL-2+ GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

RDEPEND="virtual/man"
DEPEND="${RDEPEND}"

DOCS=( CAMBIOS-1.28-1.55 CHANGES-1.28-1.55 LEEME README )

S="${WORKDIR}/${MY_P}.orig"

src_prepare(){
	rm Makefile || die
	default
}

src_install() {
	for i in {1..8}; do
		find man${i} -iname *.${i} -exec doman -i18n=es {} \;
	done
	einstalldocs
}

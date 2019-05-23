# Distributed under the terms of the GNU General Public License v2


EAPI=7

MY_P="${PN/-/}-${PV}"
DESCRIPTION="A somewhat comprehensive collection of Spanish Linux man pages"
HOMEPAGE="https://packages.debian.org/stable/manpages-es"
SRC_URI="https://deb.debian.org/debian/pool/main/m/${PN/-/}/${PN/-/}_${PV}.orig.tar.gz"

LICENSE="GPL-3+ man-pages GPL-2+ GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/man"
DEPEND="${RDEPEND}
		app-text/po4a"

DOCS=( CAMBIOS-1.28-1.55 CHANGES-1.28-1.55 LEEME README )

S="${WORKDIR}/${MY_P}.orig"

src_prepare(){
	sed -i "s/prefix/DESTDIR/g;" Makefile
	default_src_prepare
}

src_compile(){
	emake gz
	emake screen
}

src_install(){
	emake DESTDIR="${D}" remove
	default_src_install
}

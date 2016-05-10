# Distributed under the terms of the GNU General Public License v2


EAPI=5

inherit eutils

MY_P="${PN/-/}-${PV}"
DESCRIPTION="A somewhat comprehensive collection of Spanish Linux man pages - Extra files"
HOMEPAGE="https://packages.debian.org/jessie/manpages-es-extra"
SRC_URI="http://http.debian.net/debian/pool/main/m/${PN/-/}/${PN/-/}_${PV}.orig.tar.gz"

LICENSE="GPL-3+ man-pages GPL-2+ GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="virtual/man
		app-i18n/man-pages-es"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare(){
	epatch "${FILESDIR}/delete-extra-files.patch"
}

src_compile(){
	emake DESTDIR="${D}" bz2 || die "Failed compression"
}

src_install(){
	emake MANDIR="${ED}/usr/share/man/es" install || die "Failed installation"
	dodoc LEEME.extra README
}


# Distributed under the terms of the GNU General Public License v2


EAPI=7

inherit eutils

MY_P="${PN/-/}-${PV}"
DESCRIPTION="A somewhat comprehensive collection of Spanish Linux man pages - Extra files"
HOMEPAGE="https://packages.debian.org/jessie/manpages-es-extra"
SRC_URI="http://http.debian.net/debian/pool/main/m/${PN/-/}/${PN/-/}_${PV}.orig.tar.gz"

LICENSE="GPL-3+ man-pages GPL-2+ GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/man
		app-i18n/man-pages-es"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/delete-extra-files.patch" )

src_prepare(){
	default
	#Deleting some files because are already provided by sys-apps/man-db
	rm -r man3
	rm man5/resolv.conf.5
	rm man5/acct.5
	rm man5/host.conf.5
	rm man5/resolver.5
	rm man8/ld.so.8
}

src_compile(){
	emake gz
	emake screen
}

src_install(){
	emake MANDIR="${D}/usr/share/man/es" remove
	emake MANDIR="${D}/usr/share/man/es" install
	dodoc LEEME.extra README PROYECTO
}


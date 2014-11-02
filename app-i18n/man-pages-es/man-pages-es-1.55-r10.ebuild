# Distributed under the terms of the GNU General Public License v2

EAPI=4
RELEASE=`echo ${PR} | cut -c2-3`
DESCRIPTION="A somewhat comprehensive collection of Spanish Linux man pages"
HOMEPAGE="https://packages.debian.org/squeeze/manpages-es"
SRC_URI="http://ftp.de.debian.org/debian/pool/main/m/manpages-es/manpages-es_${PV}-${RELEASE}_all.deb"

LICENSE="GPL-3+ man-pages GPL-2+ GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/man"
DEPEND="${RDEPEND}
		!app-arch/deb2targz"

S="${WORKDIR}"

src_unpack(){
	unpack ${A}
	unpack ./data.tar.gz
	rm -v control.tar.gz data.tar.gz debian-binary
}

src_install(){
	insinto /
	doins -r usr
}

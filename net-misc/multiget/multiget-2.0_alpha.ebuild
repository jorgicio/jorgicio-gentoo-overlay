EAPI=5

WX_GTK_VER="2.8"

inherit wxwidgets

DESCRIPTION="MultiGet is an easy-to-use and open source file downloader."
HOMEPAGE="http://multiget.sourceforge.net"

SRC_URI="mirror://sourceforge/${PN}/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8
		sys-devel/llvm[clang]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	econf --with-wx-config=${WX_CONFIG} || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto /usr/share/applications
	doins ${FILESDIR}/multiget.desktop
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/${PN}.png
}

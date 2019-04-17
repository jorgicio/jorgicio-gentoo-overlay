

EAPI=7

inherit eutils xdg-utils

DESCRIPTION="Qt-based UNIX MAME frontend supporting SDLMAME"
HOMEPAGE="https://qmc2.batcom-it.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +arcade joystick opengl phonon +minizip +zlib tools"

DEPEND="
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtxmlpatterns:5
	media-libs/libsdl2[X,opengl?,sound,video,joystick?]
	net-misc/rsync
	x11-apps/xwininfo
	arcade? ( dev-qt/qtdeclarative:5 )
	opengl? ( dev-qt/qtopengl:5 )
	phonon? ( media-libs/phonon )
	tools? ( dev-qt/qtscript:5 )
	zlib? ( sys-libs/zlib[minizip?] )
"
RDEPEND="${DEPEND}
	>=games-emulation/sdlmame-${PV}[tools=]
"
S="${WORKDIR}/${PN}"

PATCHES=( "${FILESDIR}/${PN}-fix-phonon-include.patch" )

src_prepare(){
	sed -e "s:\$(GLOBAL_DATADIR)/applications:${ED}/usr/share/applications:g" \
		-i Makefile || die
	default_src_prepare
}

src_compile(){
	FLAGS="DESTDIR=\"${ED}\" PREFIX=/usr DATADIR=/usr/share SYSCONFDIR=/etc	CTIME=0"
	emake ${FLAGS} \
		SYSTEM_MINIZIP=$(usex minizip "1" "0") \
		SYSTEM_ZLIB=$(usex zlib "1" "0") \
		DEBUG=$(usex debug "1" "0") \
		JOYSTICK=$(usex joystick "1" "0") \
		OPENGL=$(usex opengl "1" "0") \
		PHONON=$(usex phonon "1" "0")

	use arcade && emake ${FLAGS} arcade
	use tools && emake ${FLAGS} tools
}

src_install(){
	emake ${FLAGS} install
	use arcade && emake ${FLAGS} arcade-install
	use tools && emake ${FLAGS} tools-install
}

pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}

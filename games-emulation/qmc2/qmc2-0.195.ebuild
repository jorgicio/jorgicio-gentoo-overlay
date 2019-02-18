# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Qt-based UNIX MAME frontend supporting SDLMAME"
HOMEPAGE="https://qmc2.batcom-it.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +arcade joystick opengl phonon tools"

DEPEND="
	sys-libs/zlib[minizip]
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtxmlpatterns:5
	media-libs/libsdl2[X,opengl,sound,video]
	net-misc/rsync
"
RDEPEND="${DEPEND}
	>=games-emulation/sdlmame-0.170[arcade?,tools?]
"
S="${WORKDIR}/${PN}"

src_prepare(){
	sed -e "s:\$(GLOBAL_DATADIR)/applications:${ED}usr/share/applications:g" \
		-i Makefile || die
	default_src_prepare
}

src_compile(){
	FLAGS="DESTDIR=\"${ED}\" PREFIX=/usr DATADIR=/usr/share SYSCONFDIR=/etc	CTIME=0"
	emake ${FLAGS} \
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

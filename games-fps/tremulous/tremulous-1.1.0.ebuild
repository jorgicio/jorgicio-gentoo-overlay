# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg-utils

COMMIT_CLIENT="e7f9c0265eeb09d569c5b118c9ce8e0322424014"
COMMIT_SERVER="b68ee244c4f190794ec05a8fac1f42d299250023"

DESCRIPTION="Team-based aliens vs humans FPS with buildable structures"
HOMEPAGE="http://tremulous.net"
SRC_URI="
	https://github.com/jkent/tremulous-mgclient/archive/${COMMIT_CLIENT}.tar.gz -> ${P}.tar.gz
	https://github.com/jkent/tremulous-mgtremded/archive/${COMMIT_SERVER}.tar.gz -> ${PN}-server-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua"

DEPEND="
	media-libs/freetype
	media-libs/mesa
	media-libs/openal
	media-libs/libsdl
	virtual/glu
	lua? ( dev-lang/lua:0 )
	"
RDEPEND="${DEPEND}
	games-fps/tremulous-data"

S="${WORKDIR}"

DOCS="${FILESDIR}/lakitu7_qvm.txt ${S}/${PN}-mgclient-${COMMIT_CLIENT}/docs/mg-client-manual.txt"

pkg_setup() {
	use amd64 && ARCH="amd64"
	use x86 && ARCH="x86"
}

src_prepare() {
	cd "${PN}-mgclient-${COMMIT_CLIENT}"
	sed -i "/CC=gcc-4.6/d" Makefile || die
	use !lua && sed -i "s/M-LUA/M/" Makefile || die
	cd ..
	default
}

src_compile() {
	cd "${PN}-mgclient-${COMMIT_CLIENT}"
	local flags
	use !lua && flags="USE_LUA=0"
	emake ${flags} USE_FREETYPE=0
	cd ../"${PN}-mgtremded-${COMMIT_SERVER}"
	emake release
	cd ..
}

src_install() {
	tremulous_dir="/opt/${PN}"
	cd "${PN}-mgclient-${COMMIT_CLIENT}"
	exeinto ${tremulous_dir}
	newexe build/release-linux-${ARCH}/tremulous.${ARCH} "${PN}"
	cd ../"${PN}-mgtremded-${COMMIT_SERVER}"
	exeinto ${tremulous_dir}
	newexe build/release-linux-${ARCH}/tremded.${ARCH} "tremded"
	insinto ${tremulous_dir}
	doins "${FILESDIR}/game.qvm"
	insinto /etc
	doins "${FILESDIR}/tremdedrc"
	newbin "${FILESDIR}/tremded.sh" "tremded"
	cd ..
	newbin "${FILESDIR}/${PN}.sh" "${PN}"
	doicon "${FILESDIR}/${PN}.xpm"
	domenu "${FILESDIR}/${PN}.desktop"
	einstalldocs
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

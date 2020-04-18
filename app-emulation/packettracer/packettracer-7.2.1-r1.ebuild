# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="Cisco's packet tracer"
HOMEPAGE="https://www.netacad.com/about-networking-academy/packet-tracer"
SRC_URI="
	amd64? ( "${P}-amd64.tar.gz" )
"

LICENSE="Cisco_EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="fetch mirror strip"

DEPEND="
	app-arch/gzip
	dev-util/patchelf"
RDEPEND="${DEPEND}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-libs/icu
	dev-libs/openssl:0=
	media-libs/libpng-compat:1.2
"
S="${WORKDIR}"
QA_PREBUILT="opt/packettracer/*"

pkg_nofetch(){
	ewarn "To fetch sources, you need a Cisco account which is"
	ewarn "available if you're a web-learning student, instructor"
	ewarn "or you sale Cisco hardware, etc."
	ewarn "after that, go to https://www.netacad.com and login with"
	ewarn "your account, and after that, you should download a file"
	ewarn "named \"Packet Tracer ${PV} for Linux 64bit.tar.gz\""
	ewarn "then, rename it to \"${P}-amd64.tar.gz\" and move it to"
	ewarn "your DISTDIR directory (default: /usr/portage/distfiles)"
	ewarn "and then, you can proceed with the installation."
	ewarn "Renaming is necessary due to space naming conflicts."
}

src_prepare(){
	sed -i -e "s#/opt/pt#/opt/${PN}#" bin/Cisco-PacketTracer.desktop
	sed -i -e "s#Application;Network#Network#" bin/Cisco-PacketTracer.desktop
	default
}

src_install(){
	mkdir -p "${ED}/opt/${PN}"
	cp -r . "${ED}/opt/bin"
	domenu bin/Cisco-PacketTracer.desktop
	for icon in pka pkt pkz; do
		newicon -s 48x48 -c mimetypes art/${icon}.png application-x-${icon}.png
	done
	dodoc eula${PV//./}.txt
	dobin "${FILESDIR}/${PN}"
	exeinto /opt/${PN}
	doexe "${FILESDIR}/linguist"
	insinto /etc/profile.d
	doins "${FILESDIR}/${PN}.sh"
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A music player built to serve your needs"
HOMEPAGE="https://aurous.me"
SRC_URI="
	x86? ( ${HOMEPAGE}/downloads/aurous-linux32.zip -> ${P}-x86.zip )
	amd64? ( ${HOMEPAGE}/downloads/aurous-linux64.zip -> ${P}-amd64.zip )
"

LICENSE="Custom"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	|| ( dev-java/oracle-jdk-bin:1.8[javafx]
		dev-java/oracle-jre-bin:1.8[javafx] )
	dev-libs/libgcrypt:0
	x11-libs/gksu
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install(){
	insinto "/opt/${PN}"
	doins -r *
	fperms +x "/opt/${PN}/linux/jxbrowser-chromium"
	exeinto "/usr/bin"
	doexe "${FILESDIR}/aurous"
	insinto "/usr/share/applications"
	doins "${FILESDIR}/aurous.desktop"
}

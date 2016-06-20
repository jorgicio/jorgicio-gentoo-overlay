# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{3,4,5} )

inherit eutils xdg python-r1 pax-utils

DESCRIPTION="A simple & beautiful desktop client for Whatsapp Web (binary package)"
HOMEPAGE="http://whatsie.chat"
MY_P="whatsie-${PV}"
BASE_URI="http://github.com/Aluxian/Whatsie/releases/download/v${PV}/${MY_P}-linux"
SRC_URI="
	x86? ( ${BASE_URI}-i386.deb )
	amd64? ( ${BASE_URI}-amd64.deb )
"
RESTRICT="mirror strip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	dev-util/desktop-file-utils
	>=x11-libs/gtk+-2.24:2
	x11-themes/hicolor-icon-theme
	virtual/libgudev
	dev-libs/libgcrypt:0
	x11-libs/libXtst
	dev-libs/nss
	${PYTHON_DEPS}
	sys-libs/libcap
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack "${A}"
	unpack ./data.tar.gz
	rm *.tar.gz debian-binary
}

src_install(){
	pax-mark m opt/whatsie/whatsie || die
	insinto /
	doins -r * || die
	fperms +x /opt/whatsie/whatsie || die
	fperms +x /opt/whatsie/libnode.so || die
}

pkg_postinst(){
	xdg_pkg_postinst
}

pkg_postrm(){
	xdg_pkg_postrm
}

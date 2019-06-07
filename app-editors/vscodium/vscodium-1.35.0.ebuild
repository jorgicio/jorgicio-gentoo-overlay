# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils

DESCRIPTION="Free/Libre Open Source Software Binaries of VSCode"
HOMEPAGE="https://vscodium.com"

SRC_URI="
	x86? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-ia32-${PV}.tar.gz )
	amd64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz )
	"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="global-menu libsecret qt5"

DEPEND="
	>=media-libs/libpng-1.2.46
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	gnome-base/gconf
	x11-libs/libXtst
"

RDEPEND="
	${DEPEND}
	>=net-print/cups-2.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	dev-libs/nss
	libsecret? ( app-crypt/libsecret[crypt] )
	global-menu? (
		dev-libs/libdbusmenu
		qt5? (
			dev-libs/libdbusmenu-qt
		)
	)
"

QA_PRESTRIPPED="opt/${PN}/vscodium"
QA_PREBUILT="opt/${PN}/vscodium"

S="${WORKDIR}"

src_install(){
	pax-mark m vscodium
	mkdir -p "${D}/opt/${PN}"
	cp -r . "${D}/opt/${PN}/"
	dosym "/opt/${PN}/bin/vscodium" "/usr/bin/${PN}"
	make_desktop_entry "${PN}" "VSCodium" "${PN}" "Development;IDE"
	newicon "resources/app/resources/linux/code.png" ${PN}.png
}


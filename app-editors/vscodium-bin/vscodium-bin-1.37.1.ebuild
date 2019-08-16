# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils

MY_PN="${PN/-bin}"

DESCRIPTION="Free/Libre Open Source Software Binaries of VSCode (binary version)"
HOMEPAGE="https://vscodium.com"

SRC_URI="
	amd64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz )
	"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="global-menu libsecret qt5"

DEPEND="
	>=media-libs/libpng-1.2.46
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	gnome-base/gconf
	x11-libs/libXtst
	!app-editors/vscodium
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

QA_PRESTRIPPED="opt/${MY_PN}/codium"
QA_PREBUILT="opt/${MY_PN}/codium"

S="${WORKDIR}"

src_install(){
	pax-mark m codium
	mkdir -p "${D}/opt/${MY_PN}"
	cp -r . "${D}/opt/${MY_PN}/"
	dosym "/opt/${MY_PN}/bin/codium" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/bin/codium" "/usr/bin/codium"
	make_desktop_entry "${MY_PN}" "VSCodium" "${MY_PN}" "Development;IDE"
	newicon "resources/app/resources/linux/code.png" ${MY_PN}.png
}


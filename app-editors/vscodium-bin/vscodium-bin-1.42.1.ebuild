# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils

MY_PN="${PN/-bin}"

DESCRIPTION="Free/Libre Open Source Software Binaries of VSCode (binary version)"
HOMEPAGE="https://vscodium.com"

MAJOR_VERSION="${PV:0:4}.0"

SRC_URI="
	amd64? ( https://github.com/VSCodium/vscodium/releases/download/${MAJOR_VERSION}/VSCodium-linux-x64-${PV}.tar.gz )
	arm? ( https://github.com/VSCodium/vscodium/releases/download/${MAJOR_VERSION}/VSCodium-linux-arm-${PV}.tar.gz )
	arm64? ( https://github.com/VSCodium/vscodium/releases/download/${MAJOR_VERSION}/VSCodium-linux-arm64-${PV}.tar.gz )
	"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
IUSE="pax_kernel"

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
	app-accessibility/at-spi2-atk
	>=net-print/cups-2.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/libsecret[crypt]
"

QA_PRESTRIPPED="opt/${MY_PN}/codium"
QA_PREBUILT="opt/${MY_PN}/codium"

S="${WORKDIR}"

src_install(){
	mkdir -p "${ED}/opt/${MY_PN}"
	cp -r . "${ED}/opt/${MY_PN}/"
	dosym "/opt/${MY_PN}/bin/codium" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/bin/codium" "/usr/bin/codium"
	make_desktop_entry "${MY_PN}" "VSCodium" "${MY_PN}" "Development;IDE"
	newicon "resources/app/resources/linux/code.png" ${MY_PN}.png
	use pax_kernel && pax-mark -m "${ED%/}"/opt/${MY_PN}/codium
}


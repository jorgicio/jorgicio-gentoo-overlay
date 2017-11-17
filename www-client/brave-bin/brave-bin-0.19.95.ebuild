# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

BRAVE_PN="${PN/-bin/}"

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk vi zh-CN zh-TW
"

inherit chromium-2 xdg-utils

DESCRIPTION="Brave Web Browser"
HOMEPAGE="https://brave.com"
SRC_URI="https://github.com/brave/browser-laptop/releases/download/v${PV}dev/Brave.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="gnome-base/gconf:2"
RDEPEND="
	${DEPEND}
	dev-libs/libgcrypt
	dev-libs/nss
	gnome-base/gvfs
	gnome-base/libgnome-keyring
	media-libs/alsa-lib
	net-print/cups
	sys-apps/gawk
	>=sys-libs/libcap-2
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
"

QA_PREBUILT="*"

S="${WORKDIR}/Brave-linux-x64"

src_prepare() {
	pushd "${S}/locales" > /dev/null || die
		chromium_remove_language_paks
	popd > /dev/null || die

	default
}

src_install() {
	declare BRAVE_HOME=/opt/${BRAVE_PN}

	dodir ${BRAVE_HOME%/*}

	insinto ${BRAVE_HOME}
		doins -r *

	exeinto ${BRAVE_HOME}
		doexe brave

	dosym ${BRAVE_HOME}/brave /usr/bin/${PN} || die

	newicon "${S}/resources/extensions/brave/img/braveAbout.png" "${PN}.png" || die
	newicon -s 128 "${S}/resources/extensions/brave/img/braveAbout.png" "${PN}.png" || die

	# install-xattr doesnt approve using domenu or doins from FILESDIR
	# domenu "${FILESDIR}"/${PN}.desktop
	# mkdir -p "${D}/usr/share/applications"
	cp "${FILESDIR}"/${PN}.desktop "${S}"
	domenu "${S}"/${PN}.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

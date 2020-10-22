# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 desktop pax-utils unpacker xdg-utils

MY_P="${PN}_${PV}-1"

DESCRIPTION="The Chromium-based web browser from Microsoft (development branch)"
HOMEPAGE="https://www.microsoft.com/edge https://www.microsoftedgeinsider.com"
SRC_URI="https://packages.microsoft.com/repos/edge/pool/main/${PN:0:1}/${PN}/${MY_P}_amd64.deb"

LICENSE="MS-edge"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="selinux"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-arch/bzip2
	app-accessibility/at-spi2-core
	app-accessibility/at-spi2-atk
	dev-libs/atk
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib
	dev-libs/gmp
	dev-libs/gobject-introspection
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libpcre
	dev-libs/libpthread-stubs
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/nettle
	dev-libs/nss
	dev-libs/nspr
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libepoxy
	>=media-libs/libpng-1.6.34:0
	net-dns/libidn2
	net-libs/gnutls
	net-print/cups
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXScrnSaver
	x11-libs/libxshmfence
	x11-libs/libXxf86vm
	x11-libs/pango
	x11-libs/pixman
	selinux? ( sec-policy/selinux-chromium )"
DEPEND="${RDEPEND}"

QA_PREBUILT="*"
QA_DESKTOP_HOME="usr/share/applications/${PN}.desktop"
S="${WORKDIR}"
MSEDGE_HOME="opt/microsoft/msedge-dev"

pkg_pretend() {
	use amd64 || die "This package is available for 64-bit only."
}

src_prepare() {
	rm _gpgorigin

	pushd "${MSEDGE_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	mv usr/share/appdata usr/share/metainfo || die

	rm -rf usr/share/{gnome-control-center,menu} etc || die

	mv usr/share/doc/${PN} usr/share/doc/${PF}

	default
}

src_install() {
	gzip -d usr/share/doc/${PF}/changelog.gz || die
	gzip -d usr/share/man/man1/${PN}.1.gz || die

	cp -r . "${ED}"

	for size in 16 24 32 48 64 128 256; do
		newicon -s ${size} ${MSEDGE_HOME}/product_logo_${size}_dev.png \
			${PN}.png
	done

	pax-mark m "${ED}/${MSEDGE_HOME}/${PN}"
}

pkg_postinst() {
	echo
	ewarn "This is the dev branch version of Microsoft Edge for Linux."
	ewarn "You may face some issues and bugs, so don't worry, it's a normal behavior."
	ewarn "The stable version may be available sooner or later."
	echo
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

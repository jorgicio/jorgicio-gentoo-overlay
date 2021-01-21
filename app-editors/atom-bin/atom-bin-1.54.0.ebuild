# Copyright 2011-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit desktop flag-o-matic python-any-r1 eutils unpacker pax-utils xdg-utils

DESCRIPTION="A hackable text editor for the 21st Century - Binary package"
HOMEPAGE="https://atom.io"
MY_PN="${PN//-bin}"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_PN}-amd64.tar.gz -> ${MY_PN}-${PV}-amd64.tar.gz"

RESTRICT="mirror strip bindist"

KEYWORDS="-* ~amd64"
SLOT="0"
LICENSE="MIT"

IUSE="libressl system-node"

DEPEND="${PYTHON_DEPS}
	!!dev-util/atom-shell
	!dev-util/apm
	!app-editors/atom"

# TODO: Still statically linked
# ffmpeg /usr/share/atom/./libffmpeg.so
# git    /usr/share/atom/resources/app.asar.unpacked/node_modules/dugite/git/**

# Dependencies found via ldd
# ldd /usr/share/atom/atom
RDEPEND="${DEPEND}
	system-node? ( net-libs/nodejs[npm] )
	app-accessibility/at-spi2-atk:2
	app-arch/bzip2
	app-text/hunspell
	dev-libs/atk
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib:2
	dev-libs/gmp
	dev-libs/libffi
	dev-libs/libbsd
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/libpcre
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
	media-libs/libpng
	media-libs/mesa
	net-dns/libidn2
	net-libs/gnutls
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	sys-libs/libcap
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[X]
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
	x11-libs/pixman
"

# README.md > Linux > Archive extraction
# https://github.com/atom/atom/blob/master/README.md#archive-extraction
# x11-misc/xdg-utils handled by inherit
RDEPEND="${RDEPEND}
	dev-vcs/git
	gnome-base/gconf
	x11-libs/libnotify
	gnome-base/gvfs
	app-crypt/libsecret
	libressl? ( dev-libs/libressl:0= )
	!libressl? (
		dev-libs/openssl:0=
		dev-libs/openssl-compat:1.0.0=
	)"

S="${WORKDIR}/${MY_PN}-${PV}-amd64"

QA_PRESTRIPPED="*"
QA_PREBUILT="
	usr/share/${MY_PN}/${MY_PN}
	usr/share/${MY_PN}/libffmpeg.so
	usr/share/${MY_PN}/libnode.so"

DOCS=( resources/LICENSE.md )

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare(){
	#If you want to use the system node, we don't need the local one, so we must delete it first
	if use system-node; then
		rm resources/app/apm/bin/node
		rm resources/app/apm/bin/npm
		rm resources/app/apm/BUNDLED_NODE_VERSION
		#Fix apm binary to use the nodejs binary rather than the built-in
		sed -i "s#\$binDir\/\$nodeBin#\$\(which \$nodeBin\)#" resources/app/apm/bin/apm
	fi
	default
}

src_install() {
	mkdir -p "${ED%/}/usr/share/${MY_PN}"
	cp -r . "${ED%/}/usr/share/${MY_PN}/"
	doicon "${MY_PN}.png"
	newbin "${FILESDIR}/${PN}" ${MY_PN}
	insinto "/usr/share/lintian/overrides"
	newins "${FILESDIR}/${MY_PN}-lintian" ${MY_PN}
	dosym "${EPREFIX}/usr/share/${MY_PN}/resources/app/apm/bin/apm" "${EPREFIX}/usr/bin/apm"
	einstalldocs

	make_desktop_entry "/usr/bin/${MY_PN} %U" "${MY_PN}" "${MY_PN}" \
		"GNOME;GTK;Utility;TextEditor;Development;" \
		"GenericName=Text Editor\nMimeType=text/plain;\nStartupNotify=true\nStartupWMClass=${MY_PN^}"

	pax-mark m "${ED%/}"/usr/share/${MY_PN}/${MY_PN}
}

pkg_postinst(){
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_icon_cache_update
	xdg_desktop_database_update
}

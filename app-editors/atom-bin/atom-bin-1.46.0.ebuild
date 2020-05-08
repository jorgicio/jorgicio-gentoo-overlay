# Copyright 2011-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit flag-o-matic python-any-r1 eutils unpacker pax-utils xdg-utils gnome2-utils

DESCRIPTION="A hackable text editor for the 21st Century - Binary package"
HOMEPAGE="https://atom.io"
MY_PN="${PN//-bin}"
SRC_URI="
	amd64? ( https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_PN}-amd64.tar.gz -> ${MY_PN}-${PV}-amd64.tar.gz )
"

RESTRICT="mirror strip bindist"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="MIT"

IUSE="system-node pax_kernel"

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
"

# TODO: Determine where it says we need these
RDEPEND="${RDEPEND}
	gnome-base/libgnome-keyring
	dev-libs/openssl:0=
"

PATCHES=(
	"${FILESDIR}"/${PN}-python-interceptor.patch
)

QA_PRESTRIPPED="
	usr/share/${MY_PN}/${MY_PN}
	usr/share/${MY_PN}/libffmpeg.so
	usr/share/${MY_PN}/libnode.so
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-lfs
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/symbols-view/vendor/ctags-linux
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-shell
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-show-index
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-http-backend
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-imap-send
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-credential-cache--daemon
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-remote-http
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-daemon
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-upload-pack
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-credential-cache
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-sh-i18n--envsubst
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-remote-testsvn
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-fast-import
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-credential-store
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-http-push
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/libexec/git-core/git-http-fetch
	usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/dugite/git/bin/git
"
QA_PREBUILT="
	usr/share/${MY_PN}/${MY_PN}
	usr/share/${MY_PN}/libffmpeg.so
	usr/share/${MY_PN}/libnode.so
"

DOCS=( resources/LICENSE.md )

pkg_setup() {
	python-any-r1_pkg_setup
	use amd64 && S="${WORKDIR}/${MY_PN}-${PV}-amd64" || die "Arch not supported"
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
	mkdir -p "${D}/usr/share/${MY_PN}"
	cp -r . "${D}/usr/share/${MY_PN}/"
	doicon "${MY_PN}.png"
	newbin "${FILESDIR}/${PN}" ${MY_PN}
	insinto "/usr/share/lintian/overrides"
	newins "${FILESDIR}/${MY_PN}-lintian" ${MY_PN}
	dosym "${EPREFIX}/usr/share/${MY_PN}/resources/app/apm/bin/apm" "${EPREFIX}/usr/bin/apm"
	einstalldocs

	make_desktop_entry "/usr/bin/${MY_PN} %U" "${MY_PN}" "${MY_PN}" \
		"GNOME;GTK;Utility;TextEditor;Development;" \
		"GenericName=Text Editor\nMimeType=text/plain;\nStartupNotify=true\nStartupWMClass=${MY_PN^}"

	use pax_kernel && pax-mark -m "${ED%/}"/usr/share/${MY_PN}/${MY_PN}
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

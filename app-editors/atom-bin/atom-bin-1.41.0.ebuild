# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

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
	media-fonts/inconsolata
	system-node? ( >=net-libs/nodejs-6.0[npm] )
	!!dev-util/atom-shell
	!dev-util/apm
	!app-editors/atom"

RDEPEND="${DEPEND}
	x11-libs/gtk+:2
	x11-libs/libnotify
	gnome-base/libgnome-keyring
	dev-libs/nss
	dev-libs/nspr
	gnome-base/gconf
	media-libs/alsa-lib
	net-print/cups
	sys-libs/libcap
	x11-libs/libXtst
	x11-libs/pango
	dev-vcs/git
	dev-libs/openssl:0="

PATCHES=(
	"${FILESDIR}"/${PN}-python-interceptor.patch
)

QA_PRESTRIPPED="
	usr/share/${MY_PN}/${MY_PN}
	usr/share/${MY_PN}/chromedriver/chromedriver
	usr/share/${MY_PN}/libffmpegsumo.so
	usr/share/${MY_PN}/libnotify.so.4
	usr/share/${MY_PN}/libchromiumcontent.so
	usr/share/${MY_PN}/libgcrypt.so.11
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
	usr/share/${MY_PN}/chromedriver/chromedriver
	usr/share/${MY_PN}/libffmpegsumo.so
	usr/share/${MY_PN}/libnotify.so.4
	usr/share/${MY_PN}/libchromiumcontent.so
	usr/share/${MY_PN}/libgcrypt.so.11
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
	doicon ${MY_PN}.png
	newbin ${FILESDIR}/${PN} ${MY_PN}
	insinto ${EPREFIX}/usr/share/lintian/overrides
	newins ${FILESDIR}/${MY_PN}-lintian ${MY_PN}
	dosym ${EPREFIX}/usr/share/${MY_PN}/resources/app/apm/bin/apm ${EPREFIX}/usr/bin/apm
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

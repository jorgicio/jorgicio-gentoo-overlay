# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit flag-o-matic python-any-r1 eutils unpacker pax-utils

DESCRIPTION="A hackable text editor for the 21st Century. - Binary package"
HOMEPAGE="https://atom.io"
MY_PN="atom"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_PN}-amd64.tar.gz -> ${MY_PN}-amd64-${PV}.tar.gz"

RESTRICT="mirror"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="MIT"

IUSE=""

DEPEND="${PYTHON_DEPS}
	media-fonts/inconsolata
	!!dev-util/atom-shell
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
	x11-libs/pango"

QA_PRESTRIPPED="
	/usr/share/${MY_PN}/${MY_PN}
	/usr/share/${MY_PN}/chromedriver/chromedriver
	/usr/share/${MY_PN}/libffmpegsumo.so
	/usr/share/${MY_PN}/libnotify.so.4
	/usr/share/${MY_PN}/libchromiumcontent.so
	/usr/share/${MY_PN}/libgcrypt.so.11
	/usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/symbols-view/vendor/ctags-linux"

S="${WORKDIR}/${MY_PN}-${PV}-amd64"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_install() {
	pax-mark m ${MY_PN}
	insinto ${EPREFIX}/usr/share/${MY_PN}
	doins -r .
	doicon ${MY_PN}.png
	insinto ${EPREFIX}/usr/share/doc/${MY_PN}
	newins resources/LICENSE.md copyright
	newbin ${FILESDIR}/${PN} ${MY_PN}
	insinto ${EPREFIX}/usr/share/lintian/overrides
	newins ${FILESDIR}/${MY_PN}-${PV}-lintian ${MY_PN}
	dosym ${EPREFIX}/usr/share/${MY_PN}/resources/app/apm/bin/apm ${EPREFIX}/usr/bin/apm	
	
	# Fixes permissions
	fperms +x /usr/bin/${MY_PN}
	fperms +x /usr/share/${MY_PN}/${MY_PN}
	fperms +x /usr/share/${MY_PN}/resources/app/${MY_PN}.sh
	fperms +x /usr/share/${MY_PN}/resources/app/apm/bin/apm
	fperms +x /usr/share/${MY_PN}/resources/app/apm/bin/node
	fperms +x /usr/share/${MY_PN}/resources/app/apm/node_modules/npm/bin/node-gyp-bin/node-gyp
	fperms +x /usr/share/${MY_PN}/resources/app.asar.unpacked/node_modules/symbols-view/vendor/ctags-linux

	make_desktop_entry "/usr/bin/${MY_PN} %U" "${MY_PN}" "${MY_PN}" \
		"GNOME;GTK;Utility;TextEditor;Development;" \
		"GenericName=Text Editor\nMimeType=text/plain;\nStartupNotify=true\nStartupWMClass=${MY_PN}"
}

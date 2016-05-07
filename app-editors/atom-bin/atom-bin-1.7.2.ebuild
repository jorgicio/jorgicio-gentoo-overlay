# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit flag-o-matic python-any-r1 eutils unpacker pax-utils

DESCRIPTION="A hackable text editor for the 21st Century. - Binary package"
HOMEPAGE="https://atom.io"
SRC_URI="https://github.com/atom/atom/releases/download/v${PV}/atom-amd64.deb -> atom-amd64-${PV}.deb"

RESTRICT="mirror"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="MIT"

IUSE=""

MY_PN="atom"

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
	/usr/share/atom/atom
	/usr/share/atom/chromedriver/chromedriver
	/usr/share/atom/libffmpegsumo.so
	/usr/share/atom/libnotify.so.4
	/usr/share/atom/libchromiumcontent.so
	/usr/share/atom/libgcrypt.so.11
	/usr/share/atom/resources/app.asar.unpacked/node_modules/symbols-view/vendor/ctags-linux"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_unpack() {
	unpacker_src_unpack
	mkdir -p "${S}"
	mv "${WORKDIR}/usr" "${S}"
}

src_prepare() {
	rm -r "${S}/usr/share/applications"
}

src_install() {
	pax-mark m usr/bin/atom
	into /
	insinto /
	doins -r .

	# Fixes permissions
	fperms +x /usr/bin/atom
	fperms +x /usr/share/atom/${MY_PN}
	fperms +x /usr/share/atom/resources/app/atom.sh
	fperms +x /usr/share/atom/resources/app/apm/bin/apm
	fperms +x /usr/share/atom/resources/app/apm/bin/node
	fperms +x /usr/share/atom/resources/app/apm/node_modules/npm/bin/node-gyp-bin/node-gyp
	fperms +x /usr/share/atom/resources/app.asar.unpacked/node_modules/symbols-view/vendor/ctags-linux

	make_desktop_entry "/usr/bin/atom %U" "Atom" "atom" \
		"GNOME;GTK;Utility;TextEditor;Development;" \
		"GenericName=Text Editor\nMimeType=text/plain;\nStartupNotify=true\nStartupWMClass=Atom"
}

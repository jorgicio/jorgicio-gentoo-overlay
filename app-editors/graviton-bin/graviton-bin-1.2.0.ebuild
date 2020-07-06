# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker xdg-utils

MY_PN="Graviton"
DESCRIPTION="A modern code editor (binary package)"
HOMEPAGE="https://graviton.netlify.app"
SRC_URI="https://github.com/Graviton-Code-Editor/${MY_PN}-App/releases/download/${PV}/${MY_PN}-${PV}-amd64-linux.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror strip"

RDEPEND="
	net-libs/nodejs
	media-fonts/inconsolata
	x11-libs/gtk+:3
	dev-libs/nss
	dev-libs/nspr
	net-print/cups
	x11-libs/pango
	sys-libs/libcap
	x11-libs/libXtst
	x11-libs/libnotify
	!app-editors/graviton
"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

QA_PRESTRIPPED="*"

src_unpack(){
	unpack_deb ${A}
}

src_prepare() {
	gunzip usr/share/doc/graviton/changelog.gz
	mv usr/share/doc/graviton usr/share/doc/${P}
	default
}

src_install(){
	mkdir -p "${ED%/}"
	cp -r . "${ED%/}/"

	pax-mark m "${ED%/}"/opt/${MY_PN}/${PN-bin}
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm(){
	xdg_desktop_database_update
	xdg_icon_cache_update
}

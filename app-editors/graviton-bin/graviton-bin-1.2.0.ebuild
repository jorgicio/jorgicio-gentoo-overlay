# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker xdg-utils

MY_PN="Graviton"
DESCRIPTION="Minimalist code editor (currently beta) (binary package)"
HOMEPAGE="https://graviton.ml"
SRC_URI="
	amd64? ( https://github.com/Graviton-Code-Editor/${MY_PN}-App/releases/download/${PV}/${MY_PN}-${PV}-amd64-linux.deb )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pax_kernel"
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

QA_PRESTRIPPED=(
	opt/${MY_PN}/libGLESv2.so
	opt/${MY_PN}/libEGL.so
	opt/${MY_PN}/${PN/-bin}
	opt/${MY_PN}/libffmpeg.so
)

src_unpack(){
	unpack_deb ${A}
}

src_install(){
	mkdir -p "${ED%/}"
	cp -r . "${ED%/}/"
	use pax_kernel && pax-mark -m "${ED%/}"/opt/${MY_PN}/${PN-bin}
}

pkg_preinst(){
	xdg_environment_reset
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

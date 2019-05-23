# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit desktop font multilib unpacker xdg-utils

MY_PN="ONLYOFFICE-DesktopEditors"
MY_P="${MY_PN}-${PV}-${PR//r}"

DESCRIPTION="onlyoffice is an office productivity suite (binary version)"
HOMEPAGE="https://www.onlyoffice.com/"

KEYWORDS="~amd64"


SRC_URI="
	amd64? (
		https://github.com/ONLYOFFICE/DesktopEditors/releases/download/${MY_P}/${PN/bin/desktopeditors}_amd64.deb -> ${MY_P}.deb
	)
"

SLOT="0"
RESTRICT="strip mirror"
LICENSE="AGPL-3"
IUSE=""

NATIVE_DEPEND="
	app-arch/bzip2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libffi
	dev-libs/libxml2:2
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtmultimedia:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/glu
	media-libs/gst-plugins-base:0.10
	media-libs/gstreamer:0.10
	media-libs/libpng:1.2
	net-misc/curl
	virtual/opengl
	media-libs/tiff
	sys-apps/util-linux
	sys-libs/zlib
	x11-libs/libdrm
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXxf86vm
	media-libs/libmng
	net-print/cups
	virtual/libstdc++
"
RDEPEND="
	${NATIVE_DEPEND}
	dev-db/sqlite:3
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack_deb "${A}"
}

src_install() {
	mkdir -p ${D}
	cp -r ${S}/* ${D}
	local res
	for res in 16 24 32 48 64 128 256; do
		doicon -s ${res} opt/${PN/-bin}/desktopeditors/asc-de-${res}.png
	done
}

pkg_preinst(){
	xdg_environment_reset
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mime_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mime_database_update
}

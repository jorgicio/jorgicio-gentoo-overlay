# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit fdo-mime font gnome2-utils eutils

DESCRIPTION="onlyoffice is an office productivity suite"
HOMEPAGE="http://www.onlyoffice.com/"

KEYWORDS="~amd64"

SRC_URI="
	amd64? ( http://download.${PN}.com/install/desktop/editors/linux/${PN}-desktopeditors-x64.tar.gz -> ${P}-amd64.tar.gz )
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
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/glu
	media-libs/gst-plugins-base:0.10
	media-libs/gstreamer:0.10
	media-libs/libpng:1.2
	virtual/opengl
	media-libs/tiff:3
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

src_prepare(){
	rm -r desktopeditors/dictionaries/.git
	eapply_user
}

src_install() {
	insinto /opt/${PN}
	doins -r desktopeditors
	fperms 4755 /opt/${PN}/desktopeditors/chrome-sandbox
	fperms u+x /opt/${PN}/desktopeditors/${PN}-desktopeditors.sh
	fperms u+x /opt/${PN}/desktopeditors/DesktopEditors
	dosym /opt/${PN}/desktopeditors/${PN}-desktopeditors.sh /usr/bin/${PN}-desktopeditors
	for res in 16 24 32 48 64 128 256; do
		doicon desktopeditors/asc-de-${res}.png
	done
	insinto /usr/share/licenses/${PN}
	doins desktopeditors/3DPARTYLICENSE
	local desktop_entry=(
		"${PN}-desktopeditors --system-title-bar %U"
		"ONLYOFFICE Desktop Editors"
		"asc-de"
		"Application;Office"
	)
	make_desktop_entry "${desktop_entry[@]}"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

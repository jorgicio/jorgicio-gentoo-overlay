# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/opera-developer/opera-developer-25.0.1597.0.ebuild,v 1.3 2014/08/21 12:12:55 jer Exp $

EAPI=5
CHROMIUM_LANGS="af ar az be bg bn ca cs da de el en_GB en_US es_LA es fi fr_CA
	fr fy gd hi hr hu id it ja kk ko lt lv me mk ms nb nl nn pa pl pt_BR
	pt_PT ro ru sk sr sv sw ta te th tl tr uk uz vi zh_CN zh_TW zu"
inherit chromium multilib unpacker

DESCRIPTION="A fast and secure web browser"
HOMEPAGE="http://www.opera.com/"
LICENSE="OPERA-2014"
SLOT="0"
SRC_URI_BASE="http://get.geo.opera.com/pub/"
SRC_URI="
	amd64? ( "${SRC_URI_BASE}${PN}/${PV}/linux/${PN}_${PV}_amd64.deb" )
"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	>=dev-libs/openssl-1.0.1:0
	gnome-base/gconf:2
	media-libs/alsa-lib
	media-libs/freetype
	net-misc/curl
	sys-apps/dbus
	sys-libs/libcap
	virtual/libudev
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango[X]
"

QA_PREBUILT="*"
S=${WORKDIR}
OPERA_HOME="usr/$(get_libdir)/${PN}"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	mv usr/lib/x86_64-linux-gnu usr/$(get_libdir) || die
	rm -r usr/lib || die

	rm usr/bin/${PN} || die

	rm usr/share/doc/${PN}/copyright || die
	mv usr/share/doc/${PN} usr/share/doc/${PF} || die

	pushd "${OPERA_HOME}/localization" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	sed -i \
		-e 's|^TargetEnvironment|X-&|g' \
		usr/share/applications/opera-developer.desktop || die
}

src_install() {
	mv * "${D}" || die
	dosym ../$(get_libdir)/${PN}/${PN} /usr/bin/${PN}
	dodir /usr/$(get_libdir)/${PN}/lib
	dosym /usr/$(get_libdir)/libudev.so /usr/$(get_libdir)/${PN}/lib/libudev.so.0
	fperms 4711 /usr/$(get_libdir)/${PN}/opera_sandbox
}

# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker xdg-utils

DESCRIPTION="Video conferencing and web conferencing service"
HOMEPAGE="https://zoom.us"

SRC_URI="
	amd64? ( https://zoom.us/client/${PV}/${PN}_amd64.deb -> ${P}_amd64.deb  )
	x86? ( https://zoom.us/client/${PV}/${PN}_i386.deb -> ${P}_x86.deb  )
"

LICENSE="ZOOM"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror preserve-libs split"
IUSE="alsa pax_kernel pulseaudio"

DEPEND="dev-util/patchelf"
RDEPEND="
	${DEPEND}
	pulseaudio? ( media-sound/pulseaudio[alsa?] )
	dev-db/sqlite:3
	dev-db/unixODBC
	dev-libs/nss
	dev-qt/qtsql:5
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtdeclarative:5
	dev-qt/qtsvg:5
	dev-qt/qtxmlpatterns:5
	media-libs/gst-plugins-base
	media-libs/mesa
	media-libs/fontconfig
	dev-libs/glib:2
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxshmfence
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
"

S="${WORKDIR}"

QA_PREBUILT="opt/.*"
QA_EXECSTACK="opt/zoom/zoom
	opt/zoom/libQt5WebEngineCore.so.5.9.6"

DOCS="changelog"

src_unpack() {
	unpack_deb "${A}"
}

src_prepare() {
	rm _gpgbuilder || die
	sed -i -e 's:Icon=Zoom.png:Icon=Zoom:' usr/share/applications/${PN^}.desktop || die
	sed -i -e 's:Application;::' usr/share/applications/${PN^}.desktop || die
	mv usr/share/doc/${PN}/changelog.gz .
	rm -rf usr/share/doc
	gunzip changelog.gz
	patchelf --set-rpath '$ORIGIN' opt/${PN}/platforminputcontexts/libfcitxplatforminputcontextplugin.so
	default
}

src_install() {
	mkdir -p "${ED}"
	cp -r {opt,usr} "${ED}/"
	use pax_kernel && pax-mark -m "${ED%/}"/opt/${PN}/${PN}
	default
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

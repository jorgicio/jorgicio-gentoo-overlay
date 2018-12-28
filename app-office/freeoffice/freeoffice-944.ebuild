# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="A complete, free Microsoft Office-compatible alternative office suite"
HOMEPAGE="https://www.freeoffice.com"
BASE_URI="https://www.softmaker.net/down/softmaker-${P}"
SRC_URI="
	amd64? ( "${BASE_URI}-amd64.tgz" )
	x86? ( "${BASE_URI}-i386.tgz" )
"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/chrpath"
RDEPEND="
	${DEPEND}
	x11-libs/libXrandr
	x11-misc/xdg-utils
	dev-util/desktop-file-utils
	net-misc/curl
	app-arch/xz-utils
	media-libs/mesa
"

QA_PRESTRIPPED="
	/usr/lib/freeoffice/planmaker
	/usr/lib/freeoffice/presentations
	/usr/lib/freeoffice/textmaker
"

src_unpack(){
	default_src_unpack
	xz -d "freeoffice2018.tar.lzma"
	mkdir "${WORKDIR}/${P}"
	tar x -f "freeoffice2018.tar" -C "${WORKDIR}/${P}" && rm "freeoffice2018.tar"
	rm "installfreeoffice"
}

src_prepare(){
	chrpath --delete "textmaker"
	chrpath --delete "planmaker"
	chrpath --delete "presentations"
	default_src_prepare
}

src_install(){
	insinto "${EPREFIX}/usr/$(get_libdir)/${PN}"
	doins -r *
	for m in ${FILESDIR}/*.desktop; do
		domenu "${m}"
	done
	for e in planmaker presentations textmaker; do
		dobin "${FILESDIR}/freeoffice-${e}"
	done
	for size in 16 32 48; do
		newicon icons/pml_${size}.png ${PN}-planmaker.png
		newicon icons/prl_${size}.png ${PN}-presentations.png
		newicon icons/tml_${size}.png ${PN}-textmaker.png
	done
	fperms +x "${EPREFIX}/usr/$(get_libdir)/${PN}/planmaker"
	fperms +x "${EPREFIX}/usr/$(get_libdir)/${PN}/presentations"
	fperms +x "${EPREFIX}/usr/$(get_libdir)/${PN}/textmaker"
	insinto "${EPREFIX}/usr/share/mime/packages"
	doins mime/softmaker-freeoffice18.xml
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	echo
	einfo "In order to use Softmaker Freeoffice, you need a serial number."
	einfo "To obtain a valid free serial number, please visit"
	einfo "https://www.freeoffice.com/en/download"
	echo
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils eutils fdo-mime

DESCRIPTION="A comic reader for cross-platform reading and managing your digital comic collection"
HOMEPAGE="http://www.yacreader.com"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/YACReader/${PN}.git"
else
	SRC_URI="https://github.com/YACReader/${PN}/releases/download/${PV}/${P}-src.tar.xz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
	app-text/poppler[qt5]
	dev-qt/qtdeclarative:5
	virtual/glu
	dev-qt/qtquickcontrols:5
	dev-util/desktop-file-utils
	app-arch/unarr
"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake5 YACReader.pro
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst(){
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	echo
	elog "Additional packages are required to open the most common comic archives:"
	elog
	elog "	cbr: app-arch/unrar"
	elog "	cbz: app-arch/unzip"
	elog
	elog "You can also add support for 7z files by installing app-arch/p7zip"
	elog "and LHA files by installing app-arch/lha."
	elog
	elog "If you want support for extra image files, you can do it by"
	elog "installing dev-qt/qtimageformats"
	elog
	elog "Also, if you want to add QR codes support, you can do it by"
	elog "installing media-gfx/qrencode"
	echo
}

pkg_postrm(){
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

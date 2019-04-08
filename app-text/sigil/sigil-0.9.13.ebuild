# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit cmake-utils python-single-r1 xdg-utils

my_pn="${PN^}"

DESCRIPTION="Sigil is a multi-platform WYSIWYG ebook editor for ePub format"
HOMEPAGE="http://sigil-ebook.com/"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/Sigil-Ebook/${my_pn}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Sigil-Ebook/${my_pn}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${my_pn}-${PV}"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

RDEPEND="
	app-text/hunspell
	dev-libs/boost[threads]
	dev-libs/libpcre[pcre16]
	dev-libs/xerces-c[icu]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/cssutils[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-qt/qtconcurrent-5.4:5
	>=dev-qt/qtcore-5.4:5
	>=dev-qt/qtgui-5.4:5
	>=dev-qt/qtprintsupport-5.4:5
	>=dev-qt/qtwebkit-5.4:5
	>=dev-qt/qtwidgets-5.4:5
	>=dev-qt/qtxmlpatterns-5.4:5
	sys-libs/zlib[minizip]
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-arch/unzip
"
BDEPEND="
	>=sys-devel/gcc-4.8
	>=dev-qt/linguist-tools-5.4:5
"

DOCS=( ChangeLog.txt README.md )

PATCHES=( "${FILESDIR}/${PN}-0.9.8-proper-gumbo-install.patch" )

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_LIBS=1
		-DSYSTEM_LIBS_REQUIRED=1
		-DLIBDIR="$(get_libdir)"
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	elog "From Sigil's release notes:"
	elog "When you fire up Sigil for the very first time:"
	elog "navigate to the new General Preferences and select the default"
	elog "epub version you plan to work with (epub 2 or epub3) so that new"
	elog "empty ebooks start with the correct code."
	elog "if you plan to work with epub3 epubs, you should change your"
	elog "PreserveEntities setting to use ONLY NUMERIC entities."
	elog ""
	elog "For example use & # 1 6 0 ; for non-breaking spaces and etc."
	elog ""
	elog "We strongly recommend enabling Mend On Open in your settings"
	elog "for best performance with Sigil."
}

pkg_postrm(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

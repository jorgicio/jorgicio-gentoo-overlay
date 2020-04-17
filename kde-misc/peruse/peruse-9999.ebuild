# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="forceoptional"
VIRTUALX_REQUIRED="test"
inherit ecm kde.org

DESCRIPTION="A comic book viewer based on Framework 5, for use on multiple form factors."
HOMEPAGE="http://peruse.kde.org"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="git://anongit.kde.org/${PN}.git"
else
	SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${PN}"
fi

LICENSE="LGPL-2.1"
SLOT="5"

CDEPEND="
	kde-frameworks/baloo:5
	kde-frameworks/kconfig:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kio:5
	kde-frameworks/kdeclarative:5
	kde-frameworks/kfilemetadata:5
	kde-frameworks/kirigami:5
	kde-frameworks/ki18n:5
	kde-frameworks/karchive:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
"
DEPEND="${CDEPEND}
	sys-devel/gettext
"

pkg_postinst(){
	echo
	elog "For cb* (cbr, cbz, etc.), pdf, deja-vu and epub support, you can do it by"
	elog "installing kde-apps/okular"
	echo
	ecm_pkg_postinst
}

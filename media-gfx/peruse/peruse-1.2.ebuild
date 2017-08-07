# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5

DESCRIPTION="A comic book viewer based on Framework 5, for use on multiple form factors."
HOMEPAGE="http://peruse.kde.org"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="git://anongit.kde.org/${PN}.git"
else
	SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="LGPL-2.1"
IUSE=""

DEPEND="
	$(add_frameworks_dep baloo)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kiconthemes)
	$(add_kdeapps_dep kio-extras)
	$(add_frameworks_dep extra-cmake-modules)
	$(add_frameworks_dep kdoctools)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kirigami)
	$(add_qt_dep qtgraphicaleffects)
	$(add_qt_dep qtquickcontrols)
"
RDEPEND="${DEPEND}"

pkg_postinst(){
	echo
	elog "For cb* (cbr, cbz, etc.), pdf, deja-vu and epub support, you can do it by"
	elog "installing kde-apps/okular"
	echo
}

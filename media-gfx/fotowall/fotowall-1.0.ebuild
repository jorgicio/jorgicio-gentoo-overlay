# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils eutils

DESCRIPTION="Qt5 tool for creating wallpapers"
HOMEPAGE="http://www.enricoros.com/opensource/fotowall/"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/enricoros/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/enricoros/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="qt5 opengl webcam"

RDEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtsvg:5
		opengl? ( dev-qt/qtopengl:5 )
	)
	!qt5? (
		>=dev-qt/qtcore-4.7:4
		>=dev-qt/qtgui-4.7:4
		>=dev-qt/qtsvg-4.7:4
		opengl? ( >=dev-qt/qtopengl-4.7:4 )
	)

"

# Now it uses v4l version 2
DEPEND="${RDEPEND}
	webcam? ( sys-kernel/linux-headers )
"

src_prepare() {
	default
	if ! use opengl ; then 
		eapply "${FILESDIR}/${PN}-remove-opengl-support.patch"
	fi
}

src_configure() {
	use qt5 && QTBIN="eqmake5" || QTBIN="eqmake4"
	use webcam && ${QTBIN} || ${QTBIN} ${PN}.pro "CONFIG+=no-webcam"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dodoc README.markdown
}

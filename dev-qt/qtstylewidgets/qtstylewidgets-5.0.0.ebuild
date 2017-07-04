# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils git-r3

DESCRIPTION="Additional style plugins for Qt5 (gtk2, cleanlooks, plastic, motif)"
HOMEPAGE="https://code.qt.io/cgit/qt/qtstyleplugins"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} == *9999*  ]];then
	KEYWORDS=""
else
	KEYWORDS="~x86 ~amd64 ~arm"
	EGIT_COMMIT="v${PV}"
fi

LICENSE="LGPL-2"
SLOT="5"
IUSE=""

DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	x11-libs/gtk+:2
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake5
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst(){
	echo
	einfo "To mqke QT5 applications use the gtk2 style"
	einfo "insert the following into your ~/.xprofile or ~/.profile:"
	einfo "QT_QPA_PLATFORMTHEME=gtk2"
	einfo "If you're using Wayland with GNOME, do this in your ~/.pam_environment:"
	einfo "QT_QPA_PLATFORMTHEME OVERRIDE=gtk2"
	echo
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT5_MODULE="qttools"

inherit games qt5-build

DESCRIPTION="A Qt-based version of the game 2048"
HOMEPAGE="https://github.com/xiaoyong/2048-Qt"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols[widgets]
	x11-themes/hicolor-icon-theme"
RDEPEND="${DEPEND}"

S="${WORKDIR}/2048-Qt-${PV}"

QMAKE_QT5="/usr/lib/qt5/bin/qmake"

src_compile(){
	$QMAKE_QT5 ${PN}.pro
	emake DESTDIR="${D}"
	emake -k check
}

src_install(){
	dogamesbin ${PN}
	insinto /usr/share/icons/hicolor
	doins -r icons/*
	insinto /usr/share/applications
	doins ${PN}.desktop
	doman man/${PN}.6
}

pkg_postinst(){
	elog "IMPORTANT: Add your user to the games group, and restart your current session."
	elog "After that, you can play. Enjoy!"
}

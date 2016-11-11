# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit qmake-utils

DESCRIPTION="A fork of libqtelegram by Aseman Team"
HOMEPAGE="https://github.com/Aseman-Land/libqtelegram-aseman-edition"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	MY_PV=${PV}-stable
	SRC_URI="https://github.com/Aseman-Land/libqtelegram-aseman-edition/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	KEYWORDS="~x86 ~amd64"
	S=${WORKDIR}/libqtelegram-aseman-edition-${MY_PV}
fi

LICENSE="GPLv3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtsql:5
	dev-qt/qtmultimedia:5[qml]
	dev-qt/qtquick1:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols:5
	dev-libs/openssl
	dev-libs/libappindicator
"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i 's/\/$$LIB_PATH//g' ./libqtelegram-ae.pro
	eapply_user
}

src_configure(){
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install(){
	emake INSTALL_ROOT="${D}" install || die "Failed installation"
}

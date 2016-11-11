# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="A different telegram client from Aseman team forked from Sigram by Sialan Labs. "
HOMEPAGE="http://aseman.co/en/products/cutegram/"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Aseman-Land/Cutegram"
	KEYWORDS=""
else
	MY_PV=${PV}-stable
	HASH_TOOLS="91bf14b790c749bcaaddb09a8124ef6415a93906"
	SRC_URI="
		https://github.com/Aseman-Land/Cutegram/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Aseman-Land/aseman-qt-tools/archive/${HASH_TOOLS}.tar.gz -> aseman-qt-tools-20160110.tar.gz
	"
	RESTRICT="mirror"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/Cutegram-${MY_PV}"
fi

LICENSE="GPLv3"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-libs/TelegramQML-0.9.1
	dev-qt/qtwebkit:5
	dev-qt/qtmultimedia:5
"
RDEPEND="${DEPEND}"

if [[ ${PV} != *9999* ]];then
	src_prepare(){
		cp -r ../aseman-qt-tools-${HASH_TOOLS}/* Cutegram/asemantools
		eapply_user
	}
fi

src_configure(){
	local myeqmakeargs=(
		Cutegram.pro
		PREFIX="${EPREFIX}/usr"
		DESKTOPDIR="${EPREFIX}/usr/share/applications"
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
	)
	eqmake5 ${myeqmakeargs[@]}
}

src_install(){
	emake INSTALL_ROOT="${D}" install || die "Failed installation"
}

pkg_postinst(){
	ewarn "NOTE: Two-step verification is not supported yet,"
	ewarn "so please, disable it before using Cutegram."
	ewarn "It'll be supported in version 3.0. Our apologies."
}

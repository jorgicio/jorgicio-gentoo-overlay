# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils autotools

DESCRIPTION="The Arc Icon Theme"
HOMEPAGE="https://github.com/horst3180/arc-icon-theme"
if [[ ${PV} == *99999999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="*"
	RESTRICT="mirror"
fi

LICENSE="LGPL-3.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf
	eapply_user
}

src_compile(){
	emake DESTDIR="${D}"
}

src_install(){
	emake DESTDIR="${D}" install
}

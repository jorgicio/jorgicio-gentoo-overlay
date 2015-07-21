# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit git-r3 python-r1

DESCRIPTION="A GUI frontend for ffmpeg livestreaming"
HOMEPAGE="https://github.com/TheSamsai/Castawesome"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="${PV}"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPENDS}
	x11-libs/gtk+:3
	dev-python/pygobject:2
	virtual/ffmpeg
	"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i 's#cp castawesome.py#install -Dm 755 castawesome.py#' Makefile
	sed -i 's#/usr/local#$(DESTDIR)/usr#g' Makefile
	sed -i 's#/usr/local#/usr#' castawesome.py
	sed -i 's#/usr/local#/usr#' uninstall_castawesome.sh
}

src_compile(){
	emake DESTDIR="${D}" || die
}

src_install(){
	emake DESTDIR="${D}" install || die
}

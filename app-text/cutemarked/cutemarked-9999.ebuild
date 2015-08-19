# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils git-r3

DESCRIPTION="Qt5 markdown editor"
HOMEPAGE="https://github.com/cloose/CuteMarkEd"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	app-text/discount
	app-text/hunspell
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}"-0.11.1-respect-destdir.patch
}

src_configure() {
	eqmake5 ROOT="${D}" CuteMarkEd.pro
}

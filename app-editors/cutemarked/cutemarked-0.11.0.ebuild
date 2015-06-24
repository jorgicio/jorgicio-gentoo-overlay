# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils qmake-utils git-r3

DESCRIPTION="QT Markdown Editor"
HOMEPAGE="https://cloose.github.io/CuteMarkEd"
SRC_URI=""
EGIT_REPO_URI="https://github.com/cloose/CuteMarkEd"
EGIT_COMMIT="b8b6194d6736f81c1369ef63043941ba8c3813dd"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtwebkit:5
	app-text/discount
	app-text/hunspell
	app-text/peg-markdown
"
RDEPEND="${DEPEND}"

src_configure(){
	local myeqmakeargs=(
		CuteMarkEd.pro
		PREFIX="${EPREFIX}/usr"
		DESKTOPDIR="${EPREFIX}/usr/share/applications"
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
	)
	eqmake5 ${myeqmakeargs[@]}
}

src_install(){
	emake INSTALL_ROOT="${D}" install || die
}

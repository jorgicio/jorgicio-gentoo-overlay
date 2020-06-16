# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 qmake-utils xdg

DESCRIPTION="Vim-inspired note taking application that knows programmers and Markdown better"
HOMEPAGE="https://tamlok.gitee.io/vnote"
EGIT_REPO_URI="https://github.com/tamlok/vnote.git"

LICENSE="MIT"
SLOT="0"

DEPEND="
	>=dev-qt/qtcore-5.9:5=
	>=dev-qt/qtwebengine-5.9:5=[widgets]
	>=dev-qt/qtsvg-5.9:5=
"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake5 VNote.pro
}

src_install() {
	INSTALL_ROOT="${ED%/}" default
}

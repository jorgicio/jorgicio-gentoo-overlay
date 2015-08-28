# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-r3

DESCRIPTION="Menda Circle Icon Theme"
HOMEPAGE="https://github.com/anexation/menda-icon-themes"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	x11-themes/hicolor-icon-theme
	gnome-base/librsvg
"
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/share/icons
	doins -r Menda-Circle
}

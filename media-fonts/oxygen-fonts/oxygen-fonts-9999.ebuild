# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils font git-r3

DESCRIPTION="Desktop/GUI font family for integrated use with the KDE desktop"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/oxygen-fonts"
EGIT_REPO_URI="git://anongit.kde.org/oxygen-fonts"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/extra-cmake-modules
	media-gfx/fontforge
"

src_configure() {
	local mycmakeargs=(
		-DOXYGEN_FONT_INSTALL_DIR="${FONTDIR}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	font_src_install
}

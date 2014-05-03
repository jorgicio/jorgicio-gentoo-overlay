# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/oxygen-fonts/oxygen-fonts-0_p20120917.ebuild,v 1.1 2012/09/18 07:22:02 johu Exp $

EAPI=4

inherit font git-2

DESCRIPTION="Desktop/GUI font family for integrated use with the KDE desktop"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-fonts"
EGIT_REPO_URI="git://anongit.kde.org/oxygen-fonts"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

src_install() {
	FONTS="Bold-700 mono-400 Regular-400"
	FONT_SUFFIX="ttf"

	for f in ${FONTS} ; do
		FONT_S="${S}/oxygen-fonts/${f}" font_src_install
	done
}

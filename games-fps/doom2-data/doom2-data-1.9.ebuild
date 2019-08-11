# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The IWAD used by the shareware version of Doom 2"
HOMEPAGE="http://www.idsoftware.com"
SRC_URI="http://www.pc-freak.net/files/doom-wad-files/Doom2.wad -> doom2.wad"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

S="${DISTDIR}"

DOOMWADPATH="/usr/share/doom"

src_install () {
	insinto ${DOOMWADPATH}
	doins doom2.wad
}

pkg_postinst() {
		elog "Doom 2 WAD file installed into the ${DOOMWADPATH} directory."
		elog "A Doom engine is required in order to play the doom2.wad file."
}

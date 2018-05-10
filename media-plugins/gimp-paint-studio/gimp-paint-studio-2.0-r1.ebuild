# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Gimp Paint Studio (GPS) is a collection of brushes and tool presets for making usage very comfortable."
HOMEPAGE="https://code.google.com/p/gps-gimp-paint-studio/"
MY_PN="GPS"
SRC_URI="https://github.com/draekko-rand/gps-${PN}/releases/download/${MY_PN}-v${PV}/${MY_PN}.${PV//./_}.final.zip"

LICENSE="GPL-2 CC0-1.0 Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/gimp"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install(){
	insinto ${EPREFIX}/usr/share/gimp/2.0
	doins -r *
}

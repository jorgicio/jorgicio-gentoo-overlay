# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Gimp Paint Studio (GPS) is a collection of brushes and tool presets for making usage very comfortable."
HOMEPAGE="https://code.google.com/p/gps-gimp-paint-studio/"
SRC_URI="http://gps-${PN}.googlecode.com/files/GPS_2_0.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/gimp"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install(){
	insinto ${EPREFIX}/usr/share/gimp/2.0
	for i in {brushes,dynamics,gradients,palettes,patterns,splashes,tool-presets};do
		doins -r "$i"
	done
}

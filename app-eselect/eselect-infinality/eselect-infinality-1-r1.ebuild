# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit readme.gentoo-r1

DESCRIPTION="Eselect module to choose an infinality font configuration style"
HOMEPAGE="https://github.com/yngwin/eselect-infinality"
SRC_URI="${HOMEPAGE}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/eselect"
DEPEND=""

DOC_CONTENTS="Use eselect infinality to select a font configuration style.
This is supposed to be used in pair with eselect lcdfilter."

S="${WORKDIR}/yngwin-${PN}-9dd0703"

src_prepare(){
	default
	# This fixes the symlink issue since recent versions of freetype and fontconfig, as mentioned in https://forums.gentoo.org/viewtopic-p-8205494.html
	sed -i -e "s#\"styles\.conf\.avail/\${target}\"#\"\${EROOT}/etc/fonts/infinality/styles\.conf\.avail/\${target}\"#" infinality.eselect
}

src_install() {
	dodoc README.rst
	readme.gentoo_create_doc
	insinto "/usr/share/eselect/modules"
	doins infinality.eselect
}

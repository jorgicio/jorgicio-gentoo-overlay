# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils unpacker

DESCRIPTION="Official Numix GTK Theme - Antergos edition"
HOMEPAGE="http://numixproject.org"
SRC_URI="http://repo.antergos.info/antergos/x86_64/${P}-4-any.pkg.tar.xz -> ${P}.tar.xz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack "${A}"
}

src_install(){
	insinto /usr/share/themes
	doins -r usr/share/themes/Numix*
}

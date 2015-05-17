# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A slightly modified version of the famous Numix theme, with no border, flat rounded window buttons and grey selection colour"
HOMEPAGE="http://gnome-look.org/content/show.php/Ultra-Flat?content=167473"
SRC_URI="https://www.dropbox.com/s/bx42h8a1o48w7e0/Ultra-Flat-Theme.tar.gz?dl=1 -> ${P}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Ultra-Flat"

src_install(){
	rm -r .git LICENSE
	insinto /usr/share/themes
	doins -r *
}

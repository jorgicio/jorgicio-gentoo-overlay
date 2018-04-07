# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A modern desktop theme suite, mostly flat with less shadows for depth"
HOMEPAGE="https://snwh.org/paper"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/snwh/${PN}.git"
else
	SRC_URI="https://github.com/snwh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="x11-themes/gtk-engines-flat"
DEPEND="${RDEPEND}"

src_prepare(){
	default
	eautoreconf
}

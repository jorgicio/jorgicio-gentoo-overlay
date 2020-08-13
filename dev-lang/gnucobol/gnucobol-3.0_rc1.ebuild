# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="an open-source COBOL compiler, formerly known as OpenCOBOL"
HOMEPAGE="https://www.gnu.org/software/gnucobol/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="berkdb nls"
RESTRICT="strip"

RDEPEND="
	dev-libs/gmp:0=
	berkdb? ( >=sys-libs/db-4.1:= )
	sys-libs/ncurses:0=
	sys-libs/readline:=
	!dev-lang/open-cobol"
DEPEND="${RDEPEND}
	sys-devel/libtool:="

DOCS=( AUTHORS ChangeLog NEWS README )

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e "s#MAKEFLAGS) install-data-hook#MAKEFLAGS)#" \
		libcob/Makefile.in || die
	default
}

src_configure() {
	econf \
		$(use_with berkdb db) \
		$(use_enable nls)
	default
}

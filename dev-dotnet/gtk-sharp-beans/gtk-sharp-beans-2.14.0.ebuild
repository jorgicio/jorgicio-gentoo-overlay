# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit autotools dotnet

DESCRIPTION="GTK+ API C# binding"
HOMEPAGE="http://github.com/mono/gtk-sharp-beans"
SRC_URI="http://github.com/mono/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-dotnet/gio-sharp
	>=dev-dotnet/gtk-sharp-2.12.21:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	eautoreconf
}

src_compile() {
	emake -j1 #nowarn
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README

	dotnet_multilib_comply
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_P=${P/gtk-engines-}

DESCRIPTION="A heavily modified version of the Aurora engine"
HOMEPAGE="http://gnome-look.org/content/show.php/Equinox+GTK+Engine?content=121881"
SRC_URI="http://gnome-look.org/CONTENT/content-files/121881-${MY_P}.tar.bz2
				-> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+icons"

RDEPEND="x11-libs/gtk+:2
	icons? ( x11-themes/faenza-icon-theme )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	echo Untarring engine files...
	tar xpf "${WORKDIR}/equinox-gtk-engine.tar.gz" || die
	cd "${S}"

	echo Untarring themes files...
	mkdir themes
	cd themes
	tar xpf "${WORKDIR}"/equinox-themes.tar.gz || die
}

src_configure() {
	econf --enable-animation || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS

	echo Installing themes...
	dodir /usr/share/themes/
	insinto /usr/share/themes/
	doins -r themes/* || die
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Five GTK and Metacity themes to use with Equinox GTK engine"
HOMEPAGE="http://gnome-look.org/content/show.php?content=140449"
SRC_URI="http://gnome-look.org/CONTENT/content-files/140449-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+icons"

RDEPEND=">=x11-themes/gtk-engines-equinox-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	dodir /usr/share/themes/
	insinto /usr/share/themes/
	rm *.crx || die
	doins -r * || die
}

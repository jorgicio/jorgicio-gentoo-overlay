# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Ambiance & Radiance Flat Aqua Suite for Unity, Gnome Classic, MATE, XFCE, LXDE and Openbox desktops"
HOMEPAGE=""
SRC_URI="http://download1299.mediafire.com/2olc1susxv8g/n084cio1n4sityh/Ambiance%26Radiance-FLAT-ColorSuite-14-04-1a-LTS.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3"

DEPEND="x11-themes/gtk-engines-murrine
	gtk3? ( x11-themes/gtk-engines-unico )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/"

src_install(){
	insinto /usr/share/themes
	doins -r Ambiance*Aqua* Radiance*Aqua*
	use gtk3 || {
		rm -R "${D}"/usr/share/themes/*/gtk-3.0 || die
	}
}

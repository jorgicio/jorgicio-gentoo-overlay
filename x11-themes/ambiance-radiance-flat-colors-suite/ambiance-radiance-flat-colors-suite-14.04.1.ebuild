# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Ambiance & Radiance Flat Colors Suite for Unity, Gnome Classic, MATE, XFCE, LXDE and Openbox desktops"
HOMEPAGE="http://www.ravefinity.com/p/download-ambiance-radiance-flat-colors.html"
SRC_URI=""

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3"

DEPEND="x11-themes/gtk-engines-murrine
	gtk3? ( x11-themes/gtk-engines-unico )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/"

pkg_nofetch(){
	einfo "To install this package, please, download the source file from:"
	einfo "https://drive.google.com/file/d/0B7iDWdwgu9QAcDI1U2pnaDA1ZTA/"
	einfo "or:"
	einfo "http://www.mediafire.com/download/n084cio1n4sityh/Ambiance&Radiance-FLAT-ColorSuite-14-04-1a-LTS.tar.gz"
	einfo "then, rename it \"Ambiance%26Radiance-FLAT-ColorSuite-14-04-1a-LTS.tar.gz\""
	einfo "and place it in ${DISTDIR}"
}

src_install(){
	insinto /usr/share/themes
	doins -r Ambiance* Radiance*
	use gtk3 || {
		rm -R "${D}"/usr/share/themes/*/gtk-3.0 || die
	}
}

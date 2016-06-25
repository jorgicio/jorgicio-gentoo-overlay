# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

_PN="numix-gtk-theme"
_P="${_PN}-${PV}"

DESCRIPTION="A modern flat theme that supports Gnome, Unity, XFCE and Openbox."
HOMEPAGE="https://numixproject.org"

SRC_URI="https://github.com/numixproject/${_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3.0+"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	x11-themes/gtk-engines-murrine
	dev-ruby/sass
"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	mv "${_P}" "${P}"
}

src_install() {
	insinto /usr/share/themes/Numix
	doins -r .
	dodoc README.md
}

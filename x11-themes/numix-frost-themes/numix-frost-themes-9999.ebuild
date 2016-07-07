# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

_PN="Numix-Frost"
_P="${_PN}-${PV}"

inherit eutils

DESCRIPTION="A modern flat theme that supports Gnome, Unity, XFCE and Openbox."
HOMEPAGE="https://numixproject.org"

LICENSE="GPL-3.0+"
SLOT="0"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Antergos/${_PN}"
	KEYWORDS=""
else
	KEYWORDS="*"
	SRC_URI="https://github.com/Antergos/${_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"

fi

DEPEND="
	x11-themes/gtk-engines-murrine
	dev-ruby/sass
"
RDEPEND="${DEPEND}"

if [[ ${PV} != *9999* ]];then
	src_unpack() {
		unpack "${A}"
		mv "${_P}" "${P}"
	}
fi

src_install() {
	insinto /usr/share/themes/${_PN}
	doins -r .
	dodoc README.md
}

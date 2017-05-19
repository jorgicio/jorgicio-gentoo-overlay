# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils

DESCRIPTION="A modern flat theme that supports Gnome, Unity, XFCE and Openbox."
HOMEPAGE="https://numixproject.org"

LICENSE="GPL-3"
SLOT="0"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
		EGIT_REPO_URI="https://github.com/Antergos/Numix-Frost"
	if [[ ${PV} != "9999" ]];then
		EGIT_COMMIT="a986308c4ab03f7ce5cdd758b393d9ed0781ba52"
		KEYWORDS="*"
	else
		KEYWORDS=""
	fi
else
	_PN="Numix-Frost"
	_P="${_PN}-${PV}"
	KEYWORDS="*"
	SRC_URI="https://github.com/Antergos/${_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	S="${WORKDIR}/${_P}"

fi

DEPEND="
	x11-themes/gtk-engines-murrine
	dev-ruby/sass
	dev-libs/glib:2
	x11-libs/gdk-pixbuf
"
RDEPEND="${DEPEND}"

src_prepare(){
	eapply_user
}

src_compile(){
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

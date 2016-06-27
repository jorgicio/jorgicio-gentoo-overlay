# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils ${GIT_ECLASS}

DESCRIPTION="A Material Design-like flat theme for GTK3, GTK2 and GNOME Shell"
HOMEPAGE="https://github.com/nana-4/Flat-Plat"

if [[ ${PV} == *9999* ]];then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/releases/download/${PV}/Flat-Plat-${PV}.tar.gz"
	KEYWORDS="~*"
	S="${WORKDIR}/Flat-Plat"
	RESTRICT="mirror"
fi

LICENSE="LGPL-3.0"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/gtk:2
	>=x11-libs/gtk-3.14:3
	>=x11-themes/gnome-themes-standard-3.14[gtk]
	x11-libs/gdk-pixbuf
"
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/share/themes/Flat-Plat
	doins -r *
}

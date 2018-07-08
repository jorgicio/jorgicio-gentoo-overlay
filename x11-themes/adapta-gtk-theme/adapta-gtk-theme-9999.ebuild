# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit gnome2 autotools

DESCRIPTION="An adaptive GTK+ theme based on Material Design Guidelines"
HOMEPAGE="https://github.com/adapta-project/adapta-gtk-theme"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="gnome +parallel"

DEPEND="
	>=x11-libs/gtk+-2.24.30:2
	>=x11-libs/gtk+-3.20.0:3
	>=dev-libs/libsass-3.3
	>=dev-lang/sassc-3.3
	>=media-gfx/inkscape-0.91
	dev-libs/libxml2:2
	>=x11-libs/gdk-pixbuf-2.32.2:2
	>=x11-themes/gtk-engines-murrine-0.98.1
	>=dev-libs/glib-2.48.0:2
	gnome? ( >=gnome-base/gnome-shell-3.18.3  )
	parallel? ( sys-process/parallel )
"
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf
	gnome2_src_prepare
}

src_configure(){
	econf \
		$(use_enable parallel) \
		$(use_enable gnome)
}

src_install(){
	emake DESTDIR="${D}" install
}

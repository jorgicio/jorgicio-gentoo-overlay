# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools

DESCRIPTION="A flat theme with transparent elements for GTK 3, GTK2 and GNOME Shell"
HOMEPAGE="https://github.com/horst3180/Arc-theme"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~*"
IUSE="gnome-shell +gtk2 gtk3 metacity unity xfwm"
REQUIRED_USE="|| ( gtk2 gtk3 )"

DEPEND="x11-themes/gtk-engines-murrine
		x11-libs/gdk-pixbuf"
RDEPEND="${DEPEND}
		gnome-shell? ( gnome-base/gnome-shell )
		xfwm? ( xfce-base/xfwm4 )
		gtk2? ( x11-libs/gtk+:2 )
		gtk3? ( x11-libs/gtk+:3 )
		metacity? (
			|| (
				x11-wm/metacity
				x11-wm/marco
				)
		)"

S="${WORKDIR}/Arc-theme-${PV}"

src_prepare(){
	eautoreconf
}

src_configure(){
	local myconf=''
	use !gtk2 && myconf+="--disable-gtk2 "
	use !gtk3 && myconf+="--disable-gtk3 "
	use !gnome-shell && myconf+="--disable-gnome-shell "
	use !unity && myconf+="--disable-unity "
	use !metacity && myconf+="--disable-metacity "
	use !xfwm && myconf+="--disable-xfwm "
	econf ${myconf}
}

src_compile(){
	emake DESTDIR="${D}"
}

src_install(){
	emake DESTDIR="${D}" install
}

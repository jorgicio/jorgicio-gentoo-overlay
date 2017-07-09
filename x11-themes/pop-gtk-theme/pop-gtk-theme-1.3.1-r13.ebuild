# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools

DESCRIPTION="System76 Pop GTK+ Theme, based in adapta-gtk-theme"
HOMEPAGE="http://github.com/system76/pop-gtk-theme"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}${PR}.tar.gz -> ${P}${PR}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
	S="${WORKDIR}/${P}${PR}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+parallel gnome cinnamon flashback unity xfce mate openbox plank telegram"

DEPEND="
	media-gfx/inkscape
	>=x11-libs/gdk-pixbuf-2.32.2
	>=dev-libs/glib-2.48
	>=gnome-base/librsvg-2.40.13
	>=dev-libs/libsass-3.3.6
	dev-libs/libxml2
	>=dev-lang/sassc-3.3.2
	parallel? ( sys-process/parallel )
	openbox? ( x11-wm/openbox )
	gnome? ( >=gnome-base/gnome-desktop-3.18.3 )
	mate? ( >=mate-base/mate-desktop-1.14 )
"
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf
	eapply_user
}

src_configure(){
	econf \
		$(use_enable parallel) \
		$(use_enable gnome) \
		$(use_enable cinnamon) \
		$(use_enable telegram) \
		$(use_enable flashback) \
		$(use_enable unity) \
		$(use_enable xfce) \
		$(use_enable mate) \
		$(use_enable openbox) \
		$(use_enable plank) \
		$(use_enable telegram) \
		--disable-gtk_next \
		--disable-chrome
}

src_install(){
	emake DESTDIR="${D}" install
}

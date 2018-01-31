# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils fdo-mime autotools

DESCRIPTION="Lightweight GTK+ clipboard manager. Fork of Parcellite."
HOMEPAGE="http://gtkclipit.sourceforge.net https://github.com/CristianHenzel/ClipIt"
COMMIT="ea3e1c4dd53f022289dd1c4835200ce2eab8ec98"
SRC_URI="https://github.com/CristianHenzel/ClipIt/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ClipIt-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls +gtk3 appindicator"

DEPEND="
	!gtk3? ( 
		>=x11-libs/gtk+-2.10:2 
		appindicator? ( dev-libs/libappindicator:2 )
	)
	gtk3? ( 
		x11-libs/gtk+:3
		appindicator? ( dev-libs/libappindicator:3 )
	)
	>=dev-libs/glib-2.14
	nls? (
		dev-util/intltool
		sys-devel/gettext
		)
"
RDEPEND="${DEPEND}
	x11-misc/xdotool
"

src_prepare(){
	#Some fixes
	mv configure.in configure.ac
	PATCHES=( 
		"${FILESDIR}/fixpkgandautotoolwarnings.patch"	
	)
	default
	eautoreconf
}


src_configure(){
	econf \
		$(use_enable nls) \
		$(use_enable appindicator) \
		$(use_with gtk3)
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

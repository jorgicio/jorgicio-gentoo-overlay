# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils fdo-mime git-r3

DESCRIPTION="Lightweight GTK+ clipboard manager. Fork of Parcellite."
HOMEPAGE="http://gtkclipit.sourceforge.net"
EGIT_REPO_URI="https://github.com/CristianHenzel/ClipIt"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE="appindicator nls gtk3"

DEPEND="
	!gtk3? ( >=x11-libs/gtk+-2.10:2 )
	gtk3? ( x11-libs/gtk+:3 )
	>=dev-libs/glib-2.14
	nls? (
		dev-util/intltool
		sys-devel/gettext
		)
"
RDEPEND="${DEPEND}
	appindicator? (
		!gtk3? ( dev-libs/libappindicator:2 )
		gtk3? ( dev-libs/libappindicator:3 )
	)
	x11-misc/xdotool
"

src_configure(){
	econf \
		$(use_enable appindicator) \
		$(use_enable nls) \
		$(use_with gtk3)
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

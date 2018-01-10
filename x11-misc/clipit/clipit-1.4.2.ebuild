# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils fdo-mime

DESCRIPTION="Lightweight GTK+ clipboard manager. Fork of Parcellite."
HOMEPAGE="http://gtkclipit.sourceforge.net"
SRC_URI="mirror://sourceforge/gtkclipit/Version%201/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="nls"

DEPEND="
	>=x11-libs/gtk+-2.10:2
	>=dev-libs/glib-2.14
	nls? (
		dev-util/intltool
		sys-devel/gettext
		)
"
RDEPEND="${DEPEND}
	x11-misc/xdotool
"

src_configure(){
	econf \
		$(use_enable nls)
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

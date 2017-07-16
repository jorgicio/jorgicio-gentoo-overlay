# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils gnome2-utils

DESCRIPTION="GNOME audio player for transcription"
HOMEPAGE="http://gkarsay.github.io/parlatype"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="http://github.com/gkarsay/${PN}.git"
else
	SRC_URI="http://github.com/gkarsay/${PN}/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi


LICENSE="GPL-3"
SLOT="0"
IUSE="libreoffice +introspection glade-catalog doc"

DEPEND="
	>=x11-libs/gtk+-3.10:3
	dev-util/intltool
	libreoffice? (
		|| (
			app-office/libreoffice
			app-office/libreoffice-bin
		)
	)
	introspection? (
		dev-libs/gobject-introspection
	)
	app-text/yelp-tools
	media-libs/gstreamer:1.0
	doc? (
		dev-util/gtk-doc
	)
	glade-catalog? (
		dev-util/glade
	)
"
RDEPEND="${DEPEND}
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-ugly:1.0
"

src_prepare(){
	eautoreconf
	eapply_user
}

src_configure(){
	econf \
		$(use_enable introspection) \
		$(use_with libreoffice) \
		$(use_enable doc gtk-doc) \
		$(use_enable glade-catalog)
}

src_install(){
	emake DESTDIR="${D}/" install
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
}

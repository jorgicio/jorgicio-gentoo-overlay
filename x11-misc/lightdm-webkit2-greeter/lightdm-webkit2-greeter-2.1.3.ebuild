# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools

DESCRIPTION="A webkit2 greeter for LightDM"
HOMEPAGE="https://github.com/Antergos/lightdm-webkit2-greeter"
SRC_URI="https://github.com/Antergos/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	app-text/gnome-doc-utils
	dev-libs/gobject-introspection
	dev-util/intltool
	gnome-base/gnome-common
	xfce-base/exo
"
RDEPEND="${DEPEND}
	x11-misc/lightdm
	>=net-libs/webkit-gtk-2.10.8:4/37
	>=x11-libs/gtk+-3.18.0:3
	!!x11-misc/lightdm-webkit-greeter
"
src_prepare(){
	eautoreconf
}

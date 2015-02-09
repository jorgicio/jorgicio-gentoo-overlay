# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Webkit-based greeter for LightDM"
HOMEPAGE="https://launchpad.net/${PN}"
SRC_URI="${HOMEPAGE}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/webkit-gtk:2
		x11-misc/lightdm
		dev-libs/gobject-introspection
		app-text/gnome-doc-utils
		dev-util/intltool
		"
RDEPEND="${DEPEND}"

src_prepare(){
	# What is Ambiance? This should be a GTK+ 2.x theme, so we use Clearlooks here.
  sed -i '/^theme-name=/s/Ambiance/Clearlooks/' data/lightdm-webkit-greeter.conf

  # Theme 'default' does not exist...
  sed -i '/^webkit-theme=/s/default/webkit/' data/lightdm-webkit-greeter.conf

  # this is Ubuntu branding... Replace it with something useful. ;)
  sed -i '/^background=/s|/usr/share/backgrounds/warty-final-ubuntu.png||' data/lightdm-webkit-greeter.conf
  # Replace Ubuntu font with Dejavusans
  sed -i '/^font-name=/s|Ubuntu 11|DejaVuSans 11|' data/lightdm-webkit-greeter.conf
}

src_compile(){
	econf || die "econf failed"
	emake DESTDIR="${D}" || die "emake failed"
}

src_install(){
	emake DESTDIR="${D}" install
}

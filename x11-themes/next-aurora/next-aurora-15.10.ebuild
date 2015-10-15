# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="The Ubuntu 15.10 (Wily Werewolf) theme"
HOMEPAGE="http://gnome-look.org/content/show.php/Next+Aurora?content=173859"
SRC_URI="http://gnome-look.org/CONTENT/content-files/173859-Next-Aurora.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="x86 ~x86-linux amd64 ~amd64-linux"
IUSE=""

DEPEND="
	x11-libs/gdk-pixbuf
	x11-themes/gtk-engines

"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install(){
	insinto /usr/share/themes
	doins -r Next-Aurora
}

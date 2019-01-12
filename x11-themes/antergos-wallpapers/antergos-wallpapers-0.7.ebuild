# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Wallpapers set taken from the Antergos repos"
HOMEPAGE="https://antergos.com"
SRC_URI="https://github.com/Antergos/wallpapers/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/wallpapers-${PV}"


src_prepare(){
	sed -i 's#antergos/wallpapers#backgrounds/antergos#g;' antergos-backgrounds-4-3.xml
	default_src_prepare
}

src_install(){
	insinto /usr/share/backgrounds/antergos
	doins *.jpg  *.png
	insinto /usr/share/gnome-background-properties
	doins antergos-backgrounds-4-3.xml
}

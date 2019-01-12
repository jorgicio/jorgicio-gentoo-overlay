# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Wallpapers extra set taken from the Antergos repos"
HOMEPAGE="https://antergos.com"
SRC_URI="https://github.com/Antergos/wallpapers-extra/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/wallpapers-extra-${PV}"


src_prepare(){
	sed -i 's#antergos/wallpapers-extra#backgrounds/antergos-extra#g;' antergos-extra-backgrounds-4-3.xml
	default_src_prepare
}

src_install(){
	insinto /usr/share/backgrounds/antergos-extra
	doins *.jpg  *.png
	insinto /usr/share/gnome-background-properties
	doins antergos-extra-backgrounds-4-3.xml
}

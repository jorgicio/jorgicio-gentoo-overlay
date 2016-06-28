# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils unpacker versionator

DESCRIPTION="Wallpapers set taken from the Antergos repos"
HOMEPAGE="http://antergos.com"
BASE_URI="http://repo.antergos.info/antergos"
RELEASE=$(replace_version_separator 2 '-')
MY_P="${PN}-${RELEASE//p}"
SRC_URI="
	x86? ( ${BASE_URI}/i686/${MY_P}-any.pkg.tar.xz )
	amd64? ( ${BASE_URI}/x86_64/${MY_P}-any.pkg.tar.xz )
"

LICENSE="CCPL:by-nc-sa"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack "${A}"
}

src_prepare(){
	sed -i 's#antergos/wallpapers#backgrounds/antergos#g;' usr/share/gnome-background-properties/antergos-backgrounds-4-3.xml
	eapply_user
}

src_install(){
	insinto /usr/share/backgrounds/antergos
	doins usr/share/antergos/wallpapers/*.jpg  usr/share/antergos/wallpapers/*.png
	insinto /usr/share/gnome-background-properties
	doins usr/share/gnome-background-properties/antergos-backgrounds-4-3.xml
}

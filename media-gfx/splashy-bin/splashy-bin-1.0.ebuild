# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

MY_PN="${PN//-bin}"
DESCRIPTION="Tool to set the auto changing wallpapers using Unsplash photos as desktop wallpapers"
HOMEPAGE="http://splashy.art"
SRC_URI="https://${MY_PN}.s3.amazonaws.com/${MY_PN^}-v${PV}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="strip mirror"

QA_PRESTRIPPED="opt/${MY_PN^}/${MY_PN}"

RDEPEND="
	gnome-base/gconf:2
	x11-libs/libnotify
	dev-libs/libappindicator:2
	x11-libs/libXtst
	dev-libs/nss
	x11-libs/libXScrnSaver
	net-libs/nodejs
	!media-gfx/splashy
"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_unpack(){
	unpack_deb "${A}"
}

src_install(){
	insinto /
	doins -r *
	fperms +x /opt/${MY_PN^}/libnode.so
	fperms +x /opt/${MY_PN^}/${MY_PN}
}

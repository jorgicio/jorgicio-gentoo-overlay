# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools gnome2-utils

DESCRIPTION="A MATE notification daemon theme based in the Budgie notifications used by Solus OS"
HOMEPAGE="http://solus-project.com http://github.com/solus-project"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/solus-project/${PN}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/solus-project/${PN}/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~x86 ~amd64 ~x86-linux ~amd64-linux ~arm ~arm64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-3.22.0:3"
RDEPEND="${DEPEND}
	|| (
		<x11-misc/mate-notification-daemon-1.16[gtk3]
		>=x11-misc/mate-notification-daemon-1.16
	)
"

PATCHES=( "${FILESDIR}/${PN}-5-add-numix-support.patch" )

src_prepare(){
	default_src_prepare
	eautoreconf
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_schemas_update
	gnome2_gconf_install
}

pkg_postrm(){
	gnome2_schemas_update
	gnome2_gconf_uninstall
}

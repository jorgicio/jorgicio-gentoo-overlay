# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils

DESCRIPTION="MATE notification daemon theme based in the Budgie notifications from Solus OS"
HOMEPAGE="https://solus-project.com https://github.com/solus-project"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/getsolus/${PN}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/getsolus/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-3.22.0:3"
RDEPEND="${DEPEND}
	x11-misc/mate-notification-daemon"

src_prepare(){
	default
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

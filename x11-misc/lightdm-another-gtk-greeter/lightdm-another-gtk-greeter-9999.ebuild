# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3

DESCRIPTION="Yet another GTK+ greeter for LightDM"
HOMEPAGE="https://github.com/kalgasnik/${PN}"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE="accessibility"

DEPEND="x11-misc/lightdm
		x11-libs/gtk+:3[introspection]
		dev-libs/gobject-introspection
		gnome-base/gnome-common
		sys-apps/accountsservice"
RDEPEND="${DEPEND}
		accessibility? ( app-accessibility/onboard )"

src_prepare(){
	eautoreconf
}

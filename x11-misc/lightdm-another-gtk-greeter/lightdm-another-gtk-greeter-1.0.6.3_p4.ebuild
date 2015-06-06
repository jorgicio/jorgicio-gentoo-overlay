# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools versionator

MY_PV=$(get_version_component_range 1-4)
MY_PR=${PV/*_p/}

DESCRIPTION="Yet another GTK+ greeter for LightDM"
HOMEPAGE="https://github.com/kalgasnik/${PN}"
SRC_URI="${HOMEPAGE}/archive/${MY_PV}-${MY_PR}.zip"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="accessibility"

DEPEND="x11-misc/lightdm
		x11-libs/gtk+:3[introspection]
		dev-libs/gobject-introspection
		gnome-base/gnome-common
		sys-apps/accountsservice"
RDEPEND="${DEPEND}
		accessibility? ( app-accessibility/onboard )"

S="${WORKDIR}/${PN}-${MY_PV}-${MY_PR}"

src_prepare(){
	eautoreconf
}

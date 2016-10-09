# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION="0.20"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit waf-utils vala python-any-r1

DESCRIPTION="GTK+ clipboard manager"
HOMEPAGE="https://launchpad.net/diodon"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	$(vala_depend)
	gnome-base/gconf:2
	gnome-base/dconf
	>=dev-libs/libgee-0.10.5:0.8
	dev-libs/libunique:3
	>=dev-libs/libpeas-1.1.0[python,gtk]
	>=x11-libs/libXtst-1.2.0
	dev-libs/libappindicator:3
	>=x11-libs/gtk+-3.10.0:3
"
RDEPEND="${DEPEND}
	>=gnome-extra/zeitgeist-0.9.14[introspection]
	dev-util/desktop-file-utils
	"
src_prepare(){
	default
	eapply_user
}

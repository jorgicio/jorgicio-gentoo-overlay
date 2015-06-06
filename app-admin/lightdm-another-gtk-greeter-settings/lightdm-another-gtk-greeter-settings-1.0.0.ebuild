# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )

inherit autotools eutils python-r1

DESCRIPTION="Settings editor for LightDM Another GTK+ greeter"
HOMEPAGE="https://github.com/kalgasnik/${PN}"
SRC_URI="${HOMEPAGE}/archive/${PV}.zip"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
		${PYTHON_DEPS}
		x11-misc/lightdm-another-gtk-greeter
		dev-python/pygobject:3[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf
	epatch ${FILESDIR}/${PN}-disable-update-desktop.patch
}

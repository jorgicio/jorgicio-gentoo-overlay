# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="A drop down terminal, similar to the consoles found in the first person shooters"
HOMEPAGE="http://github.com/lanoxx/tilda"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~amd64-linux ~x86-linux ~ppc ~x86-fbsd"
	S="${WORKDIR}/${PN}-${P}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	virtual/pkgconfig
	sys-devel/gettext"
RDEPEND="${DEPEND}
	x11-libs/vte:2.91
	>=dev-libs/glib-2.8.4:2
	dev-libs/confuse
	gnome-base/libglade
	x11-libs/gtk+:3"

src_prepare(){
	default
	append-cflags -std=c99
	eautoreconf
}

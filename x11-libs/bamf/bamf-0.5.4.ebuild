# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
VALA_MIN_API_VERSION=0.20
VALA_USE_DEPEND="vapigen"

inherit autotools python-r1 vala

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"

if [[ ${PV} == 9999 ]];then
	inherit bzr
	SRC_URI=""
	EBZR_REPO_URI="lp:bamf"
	KEYWORDS=""
else
	SRC_URI="https://launchpad.net/${PN}/${PV:0:3}/${PV}/+download/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1 LGPL-3"
SLOT="0"
IUSE="+introspection doc static-libs"

DEPEND="
	dev-libs/dbus-glib
	dev-util/gdbus-codegen
	dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/gtk+:3
	x11-libs/libX11
	>=x11-libs/libwnck-3.4.7:3
"
RDEPEND="${DEPEND}
	$(vala_depend)
	${PYTHON_DEPS}
	dev-libs/libxml2[python,${PYTHON_USEDEP}]
	dev-libs/libxslt[python,${PYTHON_USEDEP}]
	doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
	virtual/pkgconfig
"

DOCS=(AUTHORS COPYING COPYING.LGPL COPYING.LGPL-2.1 ChangeLog NEWS README TODO)

src_prepare(){
	sed -i 's/-Werror//' configure.ac
	sed -i 's/tests//' Makefile.am
	eautoreconf
	vala_src_prepare
	default_src_prepare
}

src_configure(){
	econf \
		--disable-gtktest \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		VALA_API_GEN="${VAPIGEN}"
}

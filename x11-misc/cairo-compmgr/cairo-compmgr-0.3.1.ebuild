# Lara Maia <dev@lara.click> 2014~2017
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit gnome2 autotools vala

DESCRIPTION="Cairo based composite manager"
HOMEPAGE="http://cairo-compmgr.tuxfamily.org https://github.com/gandalfn/Cairo-Composite-Manager"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gandalfn/Cairo-Composite-Manager"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/gandalfn/Cairo-Composite-Manager/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~x86-linux ~amd64-linux"
	S="${WORKDIR}/Cairo-Composite-Manager-${PV}"
fi

LICENSE="LGPL-3"
SLOT="0"

RDEPEND="x11-libs/gtk+:2
		 >=x11-libs/cairo-1.4
		 x11-libs/libSM
		 gnome-base/gconf"
DEPEND="${RDEPEND}
		 $(vala_depend)"

QA_PRESTRIPPED="
		usr/bin/ccm-schema-key-to-gconf
		usr/bin/cairo-compmgr"

pkg_setup() {
	G2CONF="$G2CONF --enable-gconf"
}

src_prepare() {
	sed "s/libvala-0.16/libvala-$(vala_best_api_version)/" -i configure.ac
	sed "s/libvala-0.16/libvala-$(vala_best_api_version)/" -i vapi/cairo-compmgr.deps

	epatch "$FILESDIR"/fix-compilation-errors.patch
	epatch "$FILESDIR"/bfd-ansidecl.patch
	
	gnome2_src_prepare
	vala_src_prepare
	eautoreconf
}

src_configure() {
	econf --prefix=/usr LIBS="-ldl -lgmodule-2.0 -lm -lz"
}

src_compile() {
	# parallel build broken
	emake -j1
}

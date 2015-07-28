# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib-build

MY_AUTHOR="amonakov"
DESCRIPTION="Faster OpenGL offloading for Bumblebee"
HOMEPAGE="https://github.com/${MY_AUTHOR}/${PN}"
if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="git://github.com/${MY_AUTHOR}/${PN}.git
		       https://github.com/${MY_AUTHOR}/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${MY_AUTHOR}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi


LICENSE="ISC"
SLOT="0"
IUSE=""

RDEPEND="x11-misc/bumblebee[video_cards_nvidia]
"
DEPEND="virtual/opengl"


src_compile() {
	export PRIMUS_libGLa='/usr/$$LIB/opengl/nvidia/lib/libGL.so.1'
	mymake() {
		emake LIBDIR=$(get_libdir)
	}
	multilib_parallel_foreach_abi mymake
}

src_install() {
	sed -i -e "s#^PRIMUS_libGL=.*#PRIMUS_libGL='/usr/\$LIB/primus'#" primusrun
	dobin primusrun
	myinst() {
		insinto /usr/$(get_libdir)/primus
		doins ${S}/$(get_libdir)/libGL.so.1
	}
	multilib_foreach_abi myinst
}

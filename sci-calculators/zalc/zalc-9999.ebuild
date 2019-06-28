# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils desktop

DESCRIPTION="A small, FLTK-based calculator"
HOMEPAGE="https://ziggi.org/category/developments/zalc/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ziggi/${PN}"
else
	SRC_URI="https://github.com/ziggi/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~amd64-linux ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-linux ~x86-macos"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="x11-libs/fltk"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i -e "/Version=/d" ${PN}.desktop
	cmake-utils_src_prepare
}

src_configure(){
	local mycmakeargs=(
		-DFLTK_INCLUDE_DIRS="/usr/include/fltk"
	)
	cmake-utils_src_configure
}

src_install(){
	# For some strange reason, it can't install using the provided cmake-utils install function,
	# so I'll do this manually.
	dobin "${WORKDIR}/${P}_build/${PN}"
	doicon -s 16 ${PN}.png
	domenu ${PN}.desktop
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic toolchain-funcs

MY_PN="MellowPlayer"

DESCRIPTION="Cloud music integration for your desktop"
HOMEPAGE="https://colinduquesnoy.github.io/MellowPlayer"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/colinduquesnoy/${MY_PN}.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/colinduquesnoy/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+widevine"

DEPEND="
	>=sys-devel/binutils-2.29
	>=dev-util/qbs-1.11
	media-libs/mesa
"
RDEPEND="
	${DEPEND}
	>=dev-qt/qtquickcontrols2-5.9:5
	>=dev-qt/qtwebengine-5.9:5[-bindist,widgets]
	www-plugins/adobe-flash:*
	www-plugins/chrome-binary-plugins:*[widevine?]
	x11-libs/libnotify
	widevine? ( dev-qt/qtwebengine-widevine )
"

src_prepare(){
	qbs-setup-toolchains --detect || die
	qbs-setup-qt $(which qmake) qt5 || die
	default
}

src_configure(){
	if test-flags-CXX -std=c++17;then
		if tc-is-gcc; then
			[ $(gcc-major-version) -lt 6 ] && die "You need at least GCC 6.0 in order to build ${MY_PN}"
		fi
		if tc-is-clang; then
			[ $(clang-major-version) -lt 3.5 ] && die "You need at least Clang 3.5 in order to build ${MY_PN}"
		fi
	else
		die "You need a c++17 compatible compiler in order to build ${MY_PN}"
	fi
	qbs-config defaultProfile qt5 || die
}

src_compile(){
	qbs build config:release || die
}

src_install(){
	qbs install --install-root "${D}/usr" config:release || die
}

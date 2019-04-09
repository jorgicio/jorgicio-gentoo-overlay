# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils toolchain-funcs xdg-utils

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="http://github.com/lupoDharkael/flameshot"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
IUSE="kde"

DEPEND="
	>=dev-qt/qtsvg-5.3.0:5
	>=dev-qt/qtcore-5.3.0:5
	>=dev-qt/qtdbus-5.3.0:5
	>=dev-qt/qtnetwork-5.3.0:5
	>=dev-qt/qtwidgets-5.3.0:5
	>=dev-qt/linguist-tools-5.3.0:5
"
RDEPEND="${DEPEND}
	kde? (
		kde-plasma/plasma-desktop:5
		kde-frameworks/kglobalaccel:5
	)
"

PATCHES=(
	"${FILESDIR}/${P}-fix-geometry.patch"
	"${FILESDIR}/${P}-new-captures-fix.patch"
)

src_prepare(){
	[[ ${PV} != 9999 ]] && sed -i "s|TAG_VERSION = .*|TAG_VERSION = v${PV}|" ${PN}.pro
	sed -i "s#icons#pixmaps#" ${PN}.pro
	sed -i "s#^Icon=.*#Icon=${PN}#" "docs/desktopEntry/package/${PN}.desktop" \
		"snap/gui/${PN}.desktop" \
		"snap/gui/${PN}-init.desktop"
	default_src_prepare
}

src_configure(){
	if tc-is-gcc && ver_test "$(gcc-version)" -lt 4.9.2 ;then
		die "You need at least GCC 4.9.2 to build this package"
	fi
	eqmake5 CONFIG+=packaging BASEDIR="${D}"
}

src_install(){
	INSTALL_ROOT="${D}" default_src_install
	if use kde; then
		insinto /usr/share/config/kglobalshorcuts
		newins docs/shortcuts-config/${PN}-shortcuts-kde ${PN}
	fi
}

pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}

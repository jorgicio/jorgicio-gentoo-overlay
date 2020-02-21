# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop kde5-functions qmake-utils xdg-utils

DESCRIPTION="Compositor switcher for KDE"
HOMEPAGE="https://www.muratcileli.com/compositor-switcher-for-kde"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/murat-cileli/${PN}.git"
else
	SRC_URI="https://github.com/murat-cileli/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="5"
IUSE=""
S="${S}/src"
DOCS=( ../README.md )

DEPEND="
	$(add_qt_dep qtcore)
	$(add_qt_dep qtgui)
	$(add_plasma_dep kwin)
"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake5 ${PN//-for-kde}.pro
}

src_install(){
	dobin ${PN//-for-kde}
	local desktopargs=(
		${PN//-for-kde}
		"Compositor Switcher for KDE"
		"kwin"
		"Settings"
	)
	make_desktop_entry "${desktopargs[@]}"
}

pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}

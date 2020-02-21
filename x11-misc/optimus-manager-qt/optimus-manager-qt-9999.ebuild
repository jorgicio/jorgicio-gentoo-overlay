# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 kde5-functions qmake-utils xdg-utils

DESCRIPTION="Qt-based interface for Optimus Manager"
HOMEPAGE="https://github.com/Shatur95/optimus-manager-qt"
EGIT_REPO_URI="${HOMEPAGE}"
LICENSE="GPL-3"
SLOT="0"
IUSE="plasma"

DEPEND="
	dev-qt/qtcore:5
	plasma? (
		$(add_plasma_dep plasma-desktop)
		$(add_frameworks_dep knotifications)
		$(add_frameworks_dep kiconthemes)
	)"
RDEPEND="
	${DEPEND}
	>=x11-misc/optimus-manager-1.0"

src_configure() {
	local qconf
	use plasma && qconf="DEFINES += PLASMA"
	eqmake5 "${qconf}"
}

src_install() {
	INSTALL_ROOT="${D}" default
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

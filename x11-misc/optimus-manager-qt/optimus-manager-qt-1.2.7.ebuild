# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5-functions qmake-utils xdg-utils

SINGLEAPPLICATION_VERSION="3.0.15"

DESCRIPTION="Qt-based interface for Optimus Manager"
HOMEPAGE="https://github.com/Shatur95/optimus-manager-qt"
SRC_URI="
	${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SINGLEAPPLICATION_VERSION}.tar.gz -> singleapplication-${SINGLEAPPLICATION_VERSION}.tar.gz"
KEYWORDS="~amd64 ~x86"

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

src_unpack() {
	default
	mv "${WORKDIR}/SingleApplication-${SINGLEAPPLICATION_VERSION}"/* "${WORKDIR}/${P}/src/third-party/singleapplication" || die
	rm -rf "${WORKDIR}/SingleApplication-${SINGLEAPPLICATION_VERSION}"
}

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

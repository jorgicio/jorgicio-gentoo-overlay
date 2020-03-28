# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg

SINGLEAPPLICATION_VERSION="3.0.18"

DESCRIPTION="Qt-based interface for Optimus Manager"
HOMEPAGE="https://github.com/Shatur95/optimus-manager-qt"
SRC_URI="
	${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SINGLEAPPLICATION_VERSION}.tar.gz -> singleapplication-${SINGLEAPPLICATION_VERSION}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE="plasma"
RESTRICT="test"

DEPEND="
	dev-qt/qtcore:5
	plasma? (
		kde-plasma/plasma-desktop
		kde-frameworks/knotifications
		kde-frameworks/kiconthemes
	)"
RDEPEND="
	${DEPEND}
	>=x11-misc/optimus-manager-1.2.2"

src_unpack() {
	default
	mv "${WORKDIR}/SingleApplication-${SINGLEAPPLICATION_VERSION}"/* "${WORKDIR}/${P}/src/third-party/singleapplication" || die
	rm -rf "${WORKDIR}/SingleApplication-${SINGLEAPPLICATION_VERSION}"
}

src_configure() {
	use plasma && eqmake5 "DEFINES += PLASMA" || eqmake5
}

src_install() {
	INSTALL_ROOT="${D}" default
}

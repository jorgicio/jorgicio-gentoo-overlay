# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 qmake-utils xdg-utils

QTIL_VERSION="0.4.0"

DESCRIPTION="A program enabling web-installation of items via OpenCollaborationServices"
HOMEPAGE="https://opendesktop.org/p/1136805"
EGIT_REPO_URI="https://git.opendesktop.org/akiraohgaki/${PN}.git"
SRC_URI="https://github.com/akiraohgaki/qtil/archive/v${QTIL_VERSION}.tar.gz -> qtil-${QTIL_VERSION}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-qt/qtcore-5.2.0:5
	>=dev-qt/qtdeclarative-5.2.0:5
	>=dev-qt/qtquickcontrols-5.2.0:5
	>=dev-qt/qtsvg-5.2.0:5
"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	default
}

src_prepare(){
	mv "${WORKDIR}/qtil-${QTIL_VERSION}" "${S}/lib/qtil" || die
	default
}

src_configure(){
	eqmake5 PREFIX="/usr"
}

src_install(){
	INSTALL_ROOT="${D}" default
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	echo
	elog "Thanks for installing ocs-url."
	elog "You can install packages from any page from"
	elog "https://www.opendesktop.org or related ones."
	elog "Just click on \"Install\", and then open the ocs://"
	elog "url provided by every package."
	echo
}

pkg_postrm(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

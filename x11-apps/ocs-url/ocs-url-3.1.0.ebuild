# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg-utils

DESCRIPTION="A program enabling web-installation of items via OpenCollaborationServices"
HOMEPAGE="https://opendesktop.org/p/1136805"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://git.opendesktop.org/akiraohgaki/${PN}.git"
else
	SRC_URI="https://git.opendesktop.org/akiraohgaki/${PN}/-/archive/release-${PV}/${PN}-release-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${PN}-release-${PV}"
fi

RESTRICT="network-sandbox"
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
BDEPEND="dev-vcs/git"

src_prepare(){
	./scripts/prepare || die
	default_src_prepare
}

src_configure(){
	eqmake5 PREFIX="/usr"
}

src_install(){
	INSTALL_ROOT="${D}" default_src_install
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

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit ecm kde.org python-any-r1

MY_PN="${PN/plasma-applet-}"
DESCRIPTION="Collection of minimalistic plasmoids which look like Awesome VM Widgets"
HOMEPAGE="https://store.kde.org/p/998913"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/arcan1s/${MY_PN}.git"
else
	MY_P="${MY_PN}-${PV}"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="https://github.com/arcan1s/${MY_PN}/releases/download/V.${PV}/${MY_P}-src.tar.xz"
	S="${WORKDIR}/${MY_PN}"
fi

LICENSE="GPL-3"
SLOT="5"

DEPEND="
	kde-frameworks/extra-cmake-modules:5
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"

pkg_setup(){
	python-any-r1_pkg_setup
}

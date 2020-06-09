# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Application Menu Module for Java Swing applications"
HOMEPAGE="https://gitlab.com/vala-panel-project/vala-panel-appmenu"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	S="${WORKDIR}/${P}/subprojects/${PN}"
else
	MY_PN="vala-panel-appmenu"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="${HOMEPAGE}/-/archive/${PV}/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}/subprojects/${PN}"
fi

LICENSE="LGPL-3"
SLOT="0"

DEPEND="
	>=dev-libs/glib-2.40.0
	>=dev-libs/libdbusmenu-16.04
	>=x11-libs/libxkbcommon-0.5.0"

RDEPEND="${DEPEND}
	>=virtual/jre-1.8"

BDEPEND="
	>=virtual/jdk-1.8
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DJAVA_HOME="$(java-config --jdk-home)"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	exeinto /etc/profile.d
	doexe "${FILESDIR}/${PN}.sh"
}

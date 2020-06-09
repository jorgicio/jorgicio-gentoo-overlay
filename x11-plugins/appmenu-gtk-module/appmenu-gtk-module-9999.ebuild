# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils gnome2-utils

DESCRIPTION="Application Menu GTK+ Module"
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
	>=x11-libs/gtk+-2.24.0:2
	>=x11-libs/gtk+-3.22.0:3"

RDEPEND="${DEPEND}"

BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	exeinto /etc/X11/xinit/xinitrc.d
	doexe "${FILESDIR}/80-${PN}"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
}

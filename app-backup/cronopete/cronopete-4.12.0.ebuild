# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_API_MIN_VERSION="0.36"

inherit cmake-utils gnome2-utils vala xdg

DESCRIPTION="A backup utility for Linux, inspired by Apple's Time Machine"
HOMEPAGE="https://rastersoft.com/programas/cronopete.html"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://gitlab.com/rastersoft/${PN}"
else
	SRC_URI="https://gitlab.com/rastersoft/${PN}/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	$(vala_depend)
	dev-libs/glib:2
	dev-libs/libappindicator:3
	dev-libs/libgee:0.8
	dev-util/intltool
	net-misc/rsync
	sci-libs/gsl:0=
	sys-devel/gettext[cxx]
	sys-fs/udisks:2
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-$(vala_best_api_version))"
		-DGSETTINGS_LOCALINSTALL=OFF
		-DGSETTINGS_COMPILE=OFF
		-DICON_UPDATE=OFF
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}

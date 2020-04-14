# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

DESCRIPTION="A simple and modern GTK eBook reader"
HOMEPAGE="https://johnfactotum.github.io/foliate/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/johnfactotum/${PN}"
	SRC_URI=""
else
	SRC_URI="https://github.com/johnfactotum/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="hyphen offline"

DEPEND="
	>=dev-libs/gjs-1.52[cairo,gtk,readline]
	net-libs/webkit-gtk:4/37"
RDEPEND="${DEPEND}
	hyphen? ( dev-libs/hyphen )
	offline? ( app-text/dictd )
"
BDEPEND="sys-devel/gettext"

src_install() {
	meson_src_install
	dosym com.github.johnfactotum.Foliate /usr/bin/${PN}
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}

# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION="0.26"

inherit meson vala gnome2-utils

DESCRIPTION="A GTK3 app for finding and listening to internet radio stations"
HOMEPAGE="https://github.com/haecker-felix/gradio"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P^}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	$(vala_depend)
	>=x11-libs/gtk+-3.22.6
	net-libs/libsoup
	media-libs/gstreamer
	media-libs/gst-plugins-base
	dev-libs/libgee:0.8
"
RDEPEND="${DEPEND}
	dev-db/sqlite:3
"

src_prepare(){
	export VALAC="valac-$(vala_best_api_version)"
	default
}


pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
}

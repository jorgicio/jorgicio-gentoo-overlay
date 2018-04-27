# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION="0.34"
VALA_USE_DEPEND="vapigen"

inherit autotools gnome2-utils vala

DESCRIPTION="LightDM greeter forked from Unity by Linux Mint team"
HOMEPAGE="https://github.com/linuxmint/slick-greeter"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/${PN//lightdm-}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="numlock"

DEPEND="
	$(vala_depend)
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
"
RDEPEND="${DEPEND}
	x11-libs/cairo
	media-libs/freetype
	>=x11-libs/gtk+-3.20:3
	media-libs/libcanberra
	x11-libs/libXext
	>=x11-misc/lightdm-1.12[introspection,vala]
	x11-libs/pixman
	numlock? ( x11-misc/numlockx )
"

src_prepare(){
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	eautoreconf
	default
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_schemas_update
}

pkg_postrm(){
	gnome2_schemas_update
}

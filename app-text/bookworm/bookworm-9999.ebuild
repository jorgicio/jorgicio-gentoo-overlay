# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"
PYTHON_COMPAT=( python2_7 )

inherit vala cmake-utils python-r1 gnome2

DESCRIPTION="A simple ebook reader originally intended for Elementary OS"
HOMEPAGE="http://babluboy.github.io/bookworm"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/babluboy/${PN}.git"
else
	SRC_URI="https://github.com/babluboy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	$(vala_depend)
	dev-libs/granite
	app-text/poppler[cairo]
	app-arch/unzip
	app-arch/unrar
	net-libs/webkit-gtk:4/37
	x11-libs/gtk+:3
	dev-db/sqlite:3
	dev-python/html2text[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

src_prepare(){
	export VALAC="$(type -p valac-$(vala_best_api_version))"
	DOCS="AUTHORS"
	cmake-utils_src_prepare
}

src_configure(){
	local mycmakeargs=(
		"-DICON_UPDATE=OFF"
		"-DGSETTINGS_COMPILE=OFF"
		"-DUSE_VALA_BINARY=$(type -p valac-$(vala_best_api_version))"
	)
	cmake-utils_src_configure
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

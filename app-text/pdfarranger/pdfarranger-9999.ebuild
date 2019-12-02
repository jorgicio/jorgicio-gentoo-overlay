# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1 xdg

DESCRIPTION="Small Python-GTK application for arranging PDF documents. Fork of pdfshuffler."
HOMEPAGE="https://github.com/jeromerobert/pdfarranger"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	dev-python/PyPDF2[${PYTHON_USEDEP}]
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}
	app-text/poppler[cairo,introspection]"
BDEPEND="
	${PYTHON_DEPS}
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
"

pkg_preinst(){
	xdg_environment_reset
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

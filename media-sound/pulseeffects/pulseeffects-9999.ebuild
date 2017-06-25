# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 gnome2-utils eutils

DESCRIPTION="Limiter, compressor, reverberation, equalizer and auto volume effects for Pulseaudio applications"
HOMEPAGE="https://github.com/wwmm/pulseeffects"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	python_targets_python3_4? ( dev-python/configparser )
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/gst-python:1.0[${PYTHON_USEDEP}]
	media-plugins/swh-plugins
	x11-libs/gtk+:3
	dev-python/numpy[${PYTHON_USEDEP}]
	>=sci-libs/scipy-0.18[${PYTHON_USEDEP}]
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
"
RDEPEND="${DEPEND}
	media-sound/pulseaudio[equalizer]
"

src_install(){
	distutils-r1_src_install
	insinto /usr/
	doins -r share
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

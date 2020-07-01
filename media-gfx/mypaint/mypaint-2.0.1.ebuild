# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="fast and easy graphic application for digital painters"
HOMEPAGE="http://mypaint.org"
SRC_URI="https://github.com/mypaint/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/pycairo-1.4[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	media-gfx/mypaint-brushes:2.0
	>=media-libs/libmypaint-1.6
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/swig"
BDEPEND="virtual/pkgconfig"

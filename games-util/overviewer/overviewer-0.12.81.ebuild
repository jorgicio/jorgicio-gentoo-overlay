# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="The Minecraft Overviewer tool that renders a Google Maps-like map interface"
HOMEPAGE="http://${PN}.org"
SRC_URI="${HOMEPAGE}/builds/src/5/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPENDS}
	virtual/python-imaging
	dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Minecraft-Overviewer-${PV}"

pkg_postinst(){
	elog "To use this tool, you must have a Minecraft installation first!"
	elog "To run this tool, the binary name is ${PN}.py"
}

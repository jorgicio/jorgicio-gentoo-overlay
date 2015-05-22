# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_SINGLE_TARGET="python2_7"
DISTUTILS_SINGLE_IMPL=1

inherit eutils distutils-r1

DESCRIPTION="Tweak tool for the MATE Desktop. Fork of mintDesktop."
HOMEPAGE="https://bitbucket.org/ubuntu-mate/${PN}"
SRC_URI="${HOMEPAGE}/get/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~x86 ~amd64"
COMMIT="7de2c0b5ee5f"
S="${WORKDIR}/ubuntu-mate-${PN}-${COMMIT}"

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="mate-base/mate-desktop
		dev-python/setuptools
		dev-python/python-distutils-extra
		x11-misc/wmctrl"
RDEPEND="${DEPEND}"

python_install(){
	distutils-r1_python_install
}

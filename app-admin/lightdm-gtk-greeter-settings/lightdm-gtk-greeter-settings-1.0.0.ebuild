# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_1,3_2,3_3} )
DISTUTILS_SINGLE_IMPL=1

inherit eutils distutils-r1

DESCRIPTION="Settings editor for LightDM GTK+ greeter"
HOMEPAGE="https://launchpad.net/${PN}"
SRC_URI="https://launchpad.net/${PN}/1.0/${PV}/+download/${PN}-1.0.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${PN}-1.0"

DEPEND="x11-misc/lightdm-gtk-greeter
		dev-python/python-distutils-extra
		dev-python/pygobject:3
		x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

python_install(){
	distutils-r1_python_install
}

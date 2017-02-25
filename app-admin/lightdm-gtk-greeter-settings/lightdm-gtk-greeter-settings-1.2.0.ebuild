# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )

inherit eutils distutils-r1 versionator

MY_BRANCH="$(get_version_component_range 1-2)"
DESCRIPTION="Settings editor for LightDM GTK+ greeter"
HOMEPAGE="https://launchpad.net/lightdm-gtk-greeter-settings"
SRC_URI="https://launchpad.net/${PN}/${MY_BRANCH}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEPEND="${PYTHON_DEPEND}"
DEPEND="
	${COMMON_DEPEND}
	x11-misc/lightdm-gtk-greeter
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

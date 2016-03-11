# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{1,2,3,4,5} )

inherit eutils distutils-r1 versionator

MY_BRANCH="$(get_version_component_range 1-2)"
DESCRIPTION="The easiest way to install Google Webfonts for off-line use"
HOMEPAGE="http://launchpad.net/typecatcher"
SRC_URI="http://launchpad.net/${PN}/${MY_BRANCH}/${PV}/+download/${PN}_${PV}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEPEND="${PYTHON_DEPEND}"
DEPEND="
	${COMMON_DEPEND}
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	gnome-extra/yelp
"
RDEPEND="${DEPEND}"

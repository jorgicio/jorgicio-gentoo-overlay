# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{1,2,3,4} )

inherit eutils distutils-r1 git-r3

DESCRIPTION="Tweak tool for the MATE Desktop. Fork of mintDesktop."
HOMEPAGE="https://bitbucket.org/ubuntu-mate/${PN}"
EGIT_REPO_URI="${HOMEPAGE}.git"
KEYWORDS=""
S="${WORKDIR}"/"${P}"
LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="mate-base/mate-desktop
		dev-python/setuptools
		dev-python/python-distutils-extra
		dev-python/configobj
		x11-misc/wmctrl"
RDEPEND="${DEPEND}"


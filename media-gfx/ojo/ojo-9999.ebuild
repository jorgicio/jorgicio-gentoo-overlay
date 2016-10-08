# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="A fast and good-looking image viewer"
HOMEPAGE="http://launchpad.net/ojo"
SRC_URI=""
EGIT_REPO_URI="https://github.com/peterlevi/ojo"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="${PYTHON_DEPS}
	media-libs/gexiv2[python,${PYTHON_USEDEP}]
	net-libs/webkit-gtk:3
	x11-libs/gtk+:3"
RDEPEND="${DEPEND}
	dev-util/desktop-file-utils"

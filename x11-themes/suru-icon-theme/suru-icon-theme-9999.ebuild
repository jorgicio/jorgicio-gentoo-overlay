# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit git-r3 meson

DESCRIPTION="Icon theme originally designed for Ubuntu Phone, now for Freedesktop"
HOMEPAGE="https://github.com/Ubuntu/suru-icon-theme"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

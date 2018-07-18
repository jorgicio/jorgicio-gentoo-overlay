# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit git-r3 meson

DESCRIPTION="Ubuntu community theme (GTK+ 2 and 3)"
HOMEPAGE="https://github.com/Ubuntu/gtk-communitheme"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/sassc"
RDEPEND="${DEPEND}"

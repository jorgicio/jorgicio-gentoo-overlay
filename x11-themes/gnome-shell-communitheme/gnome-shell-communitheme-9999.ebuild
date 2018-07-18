# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit git-r3 meson

DESCRIPTION="Ubuntu community theme (GNOME Shell theme)"
HOMEPAGE="https://github.com/Ubuntu/gnome-shell-communitheme"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	x11-themes/gtk-communitheme
	gnome-base/gnome-shell
	dev-lang/sassc
"
RDEPEND="${DEPEND}"

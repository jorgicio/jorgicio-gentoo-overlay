# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

CMAKE_MIN_VERSION="3.2.2"

DESCRIPTION="Linux port of FAR Manager v2"
HOMEPAGE="https://farmanager.com"
SRC_URI=""
EGIT_REPO_URI="https://github.com/elfmz/far2l"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	sys-apps/gawk
	sys-devel/m4
	dev-libs/glib:2
	x11-libs/wxGTK:3.0
"
RDEPEND="${DEPEND}"

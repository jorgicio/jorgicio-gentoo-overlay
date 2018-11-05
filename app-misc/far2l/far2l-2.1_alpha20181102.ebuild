# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION="3.2.2"

inherit cmake-utils

MY_PV="${PV:4:5}-${PV:15:2}nov${PV:11:2}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Linux port of FAR Manager v2"
HOMEPAGE="https://farmanager.com"
SRC_URI="https://github.com/elfmz/far2l/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sys-apps/gawk
	sys-devel/m4
	dev-libs/glib:2
	x11-libs/wxGTK:3.0
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${PN}-fix-prefix.patch" )

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

COMMIT="ed266dbdbd5eed0db67d2014d19a0b0d41a396bf"

DESCRIPTION="Microsoft's TrueType extra core fonts: Calibri, Consolas and Segoe Family"
HOMEPAGE="https://github.com/martinring/clide/tree/master/doc/fonts"

SRC_URI="https://github.com/martinring/clide/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MSttfEULA"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

S="${WORKDIR}/clide-${COMMIT}/doc/fonts"
FONT_S="${S}"
FONT_SUFFIX="ttf"

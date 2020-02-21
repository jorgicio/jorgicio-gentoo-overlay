# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit font

DESCRIPTION="A color and B&W emoji SVG-in-OpenType font with support for ZWJ, skin tone modifiers and country flags."
HOMEPAGE="https://github.com/eosrei/twemoji-color-font"
SRC_URI="${HOMEPAGE}/releases/download/v${PV//_/-}/TwitterColorEmoji-SVGinOT-Linux-${PV//_/-}.tar.gz"
KEYWORDS="~*"
LICENSE="MIT"
SLOT="0"

DEPEND="
	media-fonts/ttf-bitstream-vera[X?]
"
RDEPEND="${DEPEND}"

FONT_SUFFIX="ttf"
DOCS="README.md"
FONT_CONF=( fontconfig/56-twemoji-color.conf )
S="${WORKDIR}/TwitterColorEmoji-SVGinOT-Linux-${PV//_/-}"
FONT_S="${S}"

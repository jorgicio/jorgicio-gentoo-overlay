# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils font

DESCRIPTION="A color and B&W emoji SVG-in-OpenType font with support for ZWJ, skin tone modifiers and country flags."
HOMEPAGE="https://github.com/eosrei/twemoji-color-font"
SRC_URI="${HOMEPAGE}/releases/download/v${PV//_/-}/TwitterColorEmoji-SVGinOT-Linux-${PV//_/-}.zip"
KEYWORDS="~*"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="media-fonts/ttf-bitstream-vera[X?]"
RDEPEND="${DEPEND}"

FONT_SUFFIX="ttf"
DOCS="README.md"
FONT_CONF=( fontconfig/56-twemoji-color.conf )

S="${WORKDIR}"

src_prepare(){
	mv fontconfig/user-bitstream-vera-fonts.conf fontconfig/56-twemoji-color.conf
}

src_install(){
	insinto ${EPREFIX}/usr/share/licenses/${PN}
	doins ${FILESDIR}/LICENSE*
	font_src_install
}

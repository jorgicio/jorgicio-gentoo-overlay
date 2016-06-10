# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils font

DESCRIPTION="A color and B&W emoji SVG-in-OpenType font"
HOMEPAGE="https://github.com/eosrei/emojione-color-font"
SRC_URI="${HOMEPAGE}/releases/download/v${PV//_/-}/EmojiOneColor-SVGinOT-Linux-${PV//_/-}.tar.gz"
KEYWORDS="*"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="media-fonts/ttf-bitstream-vera[X?]"
RDEPEND="${DEPEND}"

FONT_SUFFIX="ttf"
DOCS="README.md"
FONT_CONF=( fontconfig/56-emojione-color.conf )

S="${WORKDIR}/EmojiOneColor-SVGinOT-Linux-${PV//_/-}"
src_install(){
	insinto ${EPREFIX}/usr/share/licenses/${PN}
	doins ${FILESDIR}/LICENSE*
	font_src_install
}

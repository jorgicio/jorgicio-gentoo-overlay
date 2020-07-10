# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

COMMIT="623761d3ee9cf4ba2b057ee4671b214110c7f155"
MY_PN="noto-fonts-emoji-apple"
MY_P="${MY_PN}-${COMMIT}"

DESCRIPTION="Google Noto Emoji Fonts replaced with Apple branded emoji"
HOMEPAGE="https://gitlab.com/timescam/noto-fonts-emoji-apple https://forum.xda-developers.com/apps/magisk/magisk-ios-13-2-emoji-t3993487"
SRC_URI="https://gitlab.com/timescam/${MY_PN}/-/archive/${COMMIT}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Although there's no file conflict, it's recommended that both
# packages may not be installed due to ttf font naming.
RDEPEND="!media-fonts/noto-emoji"

S="${WORKDIR}/${MY_P}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
FONT_CONF=( 66-noto-color-emoji.conf )
DOCS=( README.md )

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Node-build prebuilt propietary codecs for some browsers (chromium, opera, etc.)"
HOMEPAGE="https://github.com/iteufel/nwjs-ffmpeg-prebuilt"
SRC_URI="
	x86? ( ${HOMEPAGE}/releases/download/${PV}/${PV}-linux-ia32.zip -> ${P}-x86.zip )
	amd64? ( ${HOMEPAGE}/releases/download/${PV}/${PV}-linux-x64.zip -> ${P}-amd64.zip )
"

RESTRICT="mirror strip bindist"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}"
QA_PRESTRIPPED="/usr/lib/chromium-browser/libs/libffmpeg.so"

src_install(){
	insinto "/usr/$(get_libdir)/chromium-browser/libs"
	doins libffmpeg.so
	fperms +x "/usr/$(get_libdir)/chromium-browser/libs/libffmpeg.so"
}

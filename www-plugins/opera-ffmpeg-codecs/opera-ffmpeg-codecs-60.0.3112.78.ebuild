# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker

DESCRIPTION="ffmpeg extra codecs for Opera (i.e. mp3 and h.264)"
HOMEPAGE="http://ffmpeg.org"
SRC_URI="
	amd64? ( http://security.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg-extra_${PV}-0ubuntu1.1363_amd64.deb )
"

RESTRICT="mirror strip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/ffmpeg"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PRESTRIPPED="usr/lib/opera/libffmpeg.so"

src_unpack(){
	unpack_deb "${A}"
}

src_install(){
	insinto "/usr/$(get_libdir)/opera"
	doins usr/lib/chromium-browser/libffmpeg.so
}

pkg_preinst(){
	if [ -f "/usr/lib/opera/libffmpeg.so" ];then
		mv "/usr/lib/opera/libffmpeg.so" "/usr/lib/opera/libffmpeg.so.bkp"
	fi
}

pkg_postrm(){
	if [ -f "/usr/lib/opera/libffmpeg.so.bkp" ];then
		mv "/usr/lib/opera/libffmpeg.so.bkp" "/usr/lib/opera/libffmpeg.so"
	fi

}

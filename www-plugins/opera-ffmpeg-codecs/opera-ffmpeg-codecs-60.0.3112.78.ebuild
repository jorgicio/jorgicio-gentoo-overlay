# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils

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
	newins usr/lib/chromium-browser/libffmpeg.so libffmpeg.so.new
}

pkg_postinst(){
	if [ -f "/usr/$(get_libdir)/opera/libffmpeg.so" ];then
		mv "/usr/$(get_libdir)/opera/libffmpeg.so" "/usr/$(get_libdir)/opera/libffmpeg.so.bkp"
	fi
	mv "/usr/$(get_libdir)/opera/libffmpeg.so.new" "/usr/$(get_libdir)/opera/libffmpeg.so"
	echo
	ewarn "WARNING: Every time you upgrade Opera, we suggest to remove this package first"
	ewarn "to avoid file conflicts."
	echo
}

pkg_postrm(){
	if [ -f "/usr/$(get_libdir)/opera/libffmpeg.so.bkp" ];then
		mv "/usr/$(get_libdir)/opera/libffmpeg.so.bkp" "/usr/$(get_libdir)/opera/libffmpeg.so"
	fi

}

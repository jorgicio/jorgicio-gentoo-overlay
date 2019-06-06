# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="libcurl libraries linked with gnutls"
HOMEPAGE="https://curl.haxx.se"
SRC_URI="
	amd64? (
		https://mirrors.evowise.com/archlinux/community/os/x86_64/${P}-${PR//r}-x86_64.pkg.tar.xz
		https://mirrors.evowise.com/archlinux/multilib/os/x86_64/lib32-${P}-${PR//r}-x86_64.pkg.tar.xz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror strip"

DEPEND="net-misc/curl[-curl_ssl_gnutls]"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

QA_PRESTRIPPED="
	/usr/lib/libcurl-gnutls-4.5.0
	/usr/lib64/libcurl-gnutls-4.5.0
"

src_install(){
	mkdir -p "${D}/usr/$(get_libdir)"
	cp -r usr/lib/. "${D}/usr/$(get_libdir)"
	mkdir -p "${D}/usr/lib"
	cp -r usr/lib32/* "${D}/usr/lib/"
}

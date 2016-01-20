# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib unpacker

DESCRIPTION="A Qt-based program for syncing your MEGA account in your PC. This is the official app."
HOMEPAGE="http://mega.co.nz"
SRC_URI="
		x86? ( https://mega.nz/linux/MEGAsync/xUbuntu_14.04/i386/${PN}-xUbuntu_14.04_i386.deb -> ${PN}_${PV}_i386.deb )
		amd64? ( https://mega.nz/linux/MEGAsync/xUbuntu_14.04/amd64/${PN}-xUbuntu_14.04_amd64.deb -> ${PN}_${PV}_amd64.deb )
		"
RESTRICT="mirror"

LICENSE="MEGA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:4"
RDEPEND="${DEPEND}
		dev-libs/openssl
		dev-libs/libgcrypt
		media-libs/libpng
		net-dns/c-ares
		dev-libs/crypto++
		app-arch/xz-utils
		!app-arch/deb2targz
		dev-db/sqlite:3
		"

S="${WORKDIR}"

src_unpack(){
	unpack ${A}
	unpack ./data.tar.xz
	rm -v control.tar.gz data.tar.xz debian-binary
}

pkg_setup(){
	elog "This ebuild installs the binary for MEGAsync. If any problems,"
	elog "please, contact the MEGA team."
}

src_install(){
	insinto /
	doins -r usr
	fperms +x /usr/bin/megasync
	LIBCRYPTO=`equery f crypto++ | grep libcrypto++.so.0.0.0 | tail -n 1`
	LIBDIR="${LIBCRYPTO%/*}"
	dosym ${LIBDIR}/libcrypto++.so.0.0.0 ${LIBDIR}/libcrypto++.so.9
}

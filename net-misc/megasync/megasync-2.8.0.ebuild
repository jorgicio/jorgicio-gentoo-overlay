# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib versionator qmake-utils autotools

MY_PV="$(replace_all_version_separators _)"
DESCRIPTION="A Qt-based program for syncing your MEGA account in your PC. This is the official app."
HOMEPAGE="http://mega.co.nz"
SRC_URI="https://github.com/meganz/MEGAsync/archive/v${MY_PV}_0_Linux.tar.gz -> ${P}.tar.gz
	https://github.com/meganz/sdk/archive/v2.5.0.tar.gz -> ${PN}-sdk-2.5.0.tar.gz"

LICENSE="MEGA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cryptopp +sqlite libsodium +zlib +curl freeimage readline examples"

DEPEND="dev-qt/qtcore:4"
RDEPEND="${DEPEND}
		dev-libs/openssl
		dev-libs/libgcrypt
		media-libs/libpng
		net-dns/c-ares
		cryptopp? ( dev-libs/crypto++ )
		app-arch/xz-utils
		dev-libs/libuv
		sqlite? ( dev-db/sqlite:3 )
		libsodium? ( dev-libs/libsodium )
		zlib? ( sys-libs/zlib )
		curl? ( net-misc/curl )
		freeimage? ( media-libs/freeimage )
		readline? ( sys-libs/readline:0 )
		"

S="${WORKDIR}/MEGAsync-${MY_PV}_0_Linux"

src_prepare(){
	cp -r ../sdk-2.5.0/* src/MEGASync/mega
	cd src/MEGASync/mega
	eautoreconf
}

src_configure(){
	cd "${S}"/src/MEGASync/mega
	econf \
		"--disable-silent-rules" \
		"--disable-curl-checks" \
		"--disable-megaapi" \
		$(use_with zlib) \
		$(use_with sqlite) \
		$(use_with cryptopp) \
		"--with-cares" \
		$(use_with curl) \
		"--without-termcap" \
		"--disable-posix-threads" \
		$(use_with libsodium sodium) \
		$(use_with freeimage) \
		$(use_with readline) \
		$(use_enable examples)	
	cd ../..
	local myeqmakeargs=(
		MEGA.pro
		CONFIG+="release"
	)
	eqmake4 ${myeqmakeargs[@]}
	$(qt4_get_bindir)/lrelease MEGASync/MEGASync.pro
}

src_compile(){
	cd "${S}"/src
	emake INSTALL_ROOT="${D}" || die
}

src_install(){
	insinto usr/share/licenses/${PN}
	doins LICENCE.md installer/terms.txt
	cd src/MEGASync
	dobin ${PN}
	cd platform/linux/data
	insinto usr/share/applications
	doins ${PN}.desktop
	cd icons/hicolor
	for size in 16x16 32x32 48x48 128x128 256x256;do
		insinto usr/share/icons/hicolor/$size/apps/mega.png
		doins $size/apps/mega.png
	done
}

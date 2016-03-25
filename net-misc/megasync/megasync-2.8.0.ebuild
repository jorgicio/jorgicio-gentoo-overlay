# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib versionator qmake-utils autotools

MY_PV="$(replace_all_version_separators _)"
DESCRIPTION="A Qt-based program for syncing your MEGA account in your PC. This is the official app."
HOMEPAGE="http://mega.co.nz"
SRC_URI="https://github.com/meganz/MEGAsync/archive/v${MY_PV}_0_Linux.tar.gz -> ${P}.tar.gz
	https://github.com/meganz/sdk/archive/11a5370ab79a101d05130de246e96b5184aad37a.tar.gz -> ${PN}-sdk-20160324.tar.gz"
RESTRICT="mirror"

LICENSE="MEGA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ares +cryptopp +sqlite libsodium +zlib +curl freeimage readline examples threads +qt4 qt5 nautilus"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="
	qt4? ( dev-qt/qtcore:4 )
	qt5? ( 
			dev-qt/qtcore:5
			dev-qt/linguist-tools
		)"
RDEPEND="${DEPEND}
		dev-libs/openssl
		dev-libs/libgcrypt
		media-libs/libpng
		ares? ( net-dns/c-ares )
		cryptopp? ( dev-libs/crypto++ )
		app-arch/xz-utils
		dev-libs/libuv
		sqlite? ( dev-db/sqlite:3 )
		libsodium? ( dev-libs/libsodium )
		zlib? ( sys-libs/zlib )
		curl? ( net-misc/curl[ssl] )
		freeimage? ( media-libs/freeimage )
		readline? ( sys-libs/readline:0 )
		nautilus? (
			>=gnome-base/nautilus-3.12.0
			!!gnome-extra/nautilus-megasync 
			)
		"

S="${WORKDIR}/MEGAsync-${MY_PV}_0_Linux"

src_prepare(){
	cp -r ../sdk-11a5370ab79a101d05130de246e96b5184aad37a/* src/MEGASync/mega
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
		$(use_with ares cares) \
		$(use_with curl) \
		"--without-termcap" \
		$(use_enable threads posix-threads) \
		$(use_with libsodium sodium) \
		$(use_with freeimage) \
		$(use_with readline) \
		$(use_enable examples)	
	cd ../..
	local myeqmakeargs=(
		MEGA.pro
		CONFIG+="release"
	)
	use nautilus && myeqmakeargs+=( CONFIG+="with_ext" )
	if use qt4; then
		eqmake4 ${myeqmakeargs[@]}
		$(qt4_get_bindir)/lrelease MEGASync/MEGASync.pro
	elif use qt5; then
		eqmake5 ${myeqmakeargs[@]}
		$(qt5_get_bindir)/lrelease MEGASync/MEGASync.pro
	fi
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
	if use nautilus; then
		cd "${S}/src/MEGAShellExtNautilus"
		insinto usr/lib/nautilus/extensions-3.0
		doins libMEGAShellExtNautilus.so.1.0.0
		cd data/emblems
		for size in 32x32 64x64;do
			insinto usr/share/icons/hicolor/$size/emblems
			doins $size/mega-{pending,synced,syncing,upload}.{icon,png}
			dosym usr/lib/nautilus/extensions-3.0/libMEGAShellExtNautilus.so.1.0.0 usr/lib/nautilus/extensions-3.0/libMEGAShellExtNautilus.so.1.0
			dosym usr/lib/nautilus/extensions-3.0/libMEGAShellExtNautilus.so.1.0.0 usr/lib/nautilus/extensions-3.0/libMEGAShellExtNautilus.so.1
			dosym usr/lib/nautilus/extensions-3.0/libMEGAShellExtNautilus.so.1.0.0 usr/lib/nautilus/extensions-3.0/libMEGAShellExtNautilus.so
		done
	fi
}

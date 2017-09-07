# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Open-source prodictivity booster with a brain"
HOMEPAGE="http://cerebroapp.com"

KEYWORDS="~x86 ~amd64"
SRC_URI="https://github.com/KELiON/cerebro/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="strip"

DEPEND="
	>=net-libs/nodejs-6.0.0
	sys-apps/yarn
"
RDEPEND="${DEPEND}
	media-libs/alsa-lib
	gnome-base/gconf
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	dev-libs/nss"

QA_PRESTRIPPED="
	usr/lib/${PN}/libnode.so
	usr/lib/${PN}/libffmpeg.so
	usr/lib/${PN}/${PN}
"

src_compile(){
	yarn && cd ./app && yarn && cd ../
	yarn run build
	use amd64 && ARCH="x64" || ARCH="ia32"
	node_modules/.bin/build --linux "--${ARCH}" --dir
}

src_install(){
	insinto /usr/lib/${PN}
	if use amd64;then
		doins -r release/linux-unpacked/*
		dosym /usr/lib/${PN}/${PN} /usr/bin/${PN}
	else
		doins -r release/linux-ia32-unpacked/*
		dosym /usr/lib/${PN}/${PN} /usr/bin/${PN}
	fi
	for res in 16x16 32x32 48x48 128x128 256x256 512x512 1024x1024;do
		doicon build/icons/${res}.png
	done
	newicon build/icons/48x48.png ${PN}.png
	insinto /usr/share/licenses/${PN}
	use amd64 && doins release/linux-unpacked/LICENSE*.* || doins release/linux-ia32-unpacked/LICENSE*.*
	fperms +x /usr/lib/${PN}/${PN}
	fperms +x /usr/lib/${PN}/libnode.so
	local make_desktop_entry_args=(
		"${EPREFIX}/usr/bin/${PN}"
		"${PN^}"
		"${PN}"
		"System"
	)
	make_desktop_entry "${make_desktop_entry_args[@]}"
}

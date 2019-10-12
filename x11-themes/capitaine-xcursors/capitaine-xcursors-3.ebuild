# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

MY_PN="${PN/xcursors/cursors}"

DESCRIPTION="An x-cursor theme inspired by macOS and based on KDE Breeze"
HOMEPAGE="https://github.com/keeferrourke/capitaine-cursors"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	MY_PV="r${PV}"
	MY_P="${MY_PN}-${MY_PV}"
	SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~x86-linux ~amd64-linux ~x86-fbsd ~amd64-fbsd ~arm ~arm64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="binary imagemagick"
REQUIRED_USE="imagemagick? ( !binary )"

BDEPEND="
	!binary? (
		imagemagick? ( media-gfx/imagemagick )
		!imagemagick? ( media-gfx/inkscape )
		x11-apps/xcursorgen
	)
"

DOCS=(
	COPYING
	README.md
	preview.png
	product.svg
)

src_prepare() {
	use imagemagick && eapply "${FILESDIR}/${PN}-3-convert-fix.patch"
	default
	use !binary && ( rm -rf dist dist-white || die )
}

src_compile(){
	use !binary && ./build.sh
}

src_install(){
	insinto /usr/share/cursors/xorg-x11/${MY_PN}
	doins -r dist/*
	insinto /usr/share/cursors/xorg-x11/${MY_PN}-white
	doins -r dist-white/*
	default
}

pkg_preinst(){
	xdg_environment_reset
}

pkg_postinst(){
	xdg_icon_cache_update
}

pkg_postrm(){
	xdg_icon_cache_update
}

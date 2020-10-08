# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

OBS_MIN_VER="23.0.2"
MY_PN="${PN/obs-}"
MY_P="${MY_PN}${PV}-obs${OBS_MIN_VER}"

DESCRIPTION="Browser source plugin for obs-studio based on CEF."
HOMEPAGE="https://github.com/bazukas/obs-linuxbrowser"
SRC_URI="${HOMEPAGE}/releases/download/${PV}/${MY_P}-64bit.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

RDEPEND="
	dev-libs/atk
	dev-libs/nss
	>=media-video/obs-studio-${OBS_MIN_VER}
	x11-libs/pango
	x11-libs/libXcomposite
	x11-libs/libXrandr"
DEPEND="${RDEPEND}"

QA_PRESTRIPPED="*"

S="${WORKDIR}/${PN}"

src_install() {
	mkdir -p "${ED}"/usr/$(get_libdir)/obs-plugins
	cp -r bin/64bit/* "${ED}"/usr/$(get_libdir)/obs-plugins

	mkdir -p "${ED}"/usr/share/obs/obs-plugins/${PN}
	cp -r data/* "${ED}"/usr/share/obs/obs-plugins/${PN}
}

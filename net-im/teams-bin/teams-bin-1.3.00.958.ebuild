# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

MY_PN="${PN/-bin}"

DESCRIPTION="Microsoft Teams for Linux is your chat-centered workspace in Office 365"
HOMEPAGE="https://teams.microsoft.com/downloads"
SRC_URI="
	amd64? ( https://packages.microsoft.com/repos/ms-${MY_PN}/pool/main/${PN:0:1}/${MY_PN}/${MY_PN}_${PV}_amd64.deb )"

LICENSE="Ms-PL"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

RDEPEND="
	app-crypt/libsecret
	dev-libs/nss
	media-libs/alsa-lib
	>=sys-libs/glibc-2.28-r4
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	!net-im/teams"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_prepare() {
	rm _gpgorigin || die
	default
}

src_install() {
	mkdir -p "${ED}"
	cp -r . "${ED}/"
}

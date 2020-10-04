# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The cross-shell prompt for astronauts (binary version)"
HOMEPAGE="https://starship.rs"
SRC_URI="
	elibc_glibc? ( https://github.com/starship/${MY_PN}/releases/download/v${PV}/${MY_PN}-x86_64-unknown-linux-gnu.tar.gz -> ${MY_P}-x86_64-glibc.tar.gz )
	elibc_musl? ( https://github.com/starship/${MY_PN}/releases/download/v${PV}/${MY_PN}-x86_64-unknown-linux-musl.tar.gz -> ${MY_P}-x86_64-musl.tar.gz )"

LICENSE="ISC"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="elibc_glibc elibc_musl libressl"
RESTRICT="mirror strip"

DEPEND="
	elibc_glibc? ( sys-libs/glibc )
	elibc_musl? ( sys-libs/musl )
"
RDEPEND="
	${DEPEND}
	!app-shells/starship
	libressl? ( dev-libs/libressl:0 )
	!libressl? ( dev-libs/openssl:0 )
	sys-libs/zlib"

S="${WORKDIR}"

src_install() {
	dobin ${MY_PN}
	default
}

pkg_postinst() {
	echo
	elog "Thanks for installing starship."
	elog "For better experience, it's suggested to install some Powerline font."
	elog "You can get some from https://github.com/powerline/fonts"
	echo
}

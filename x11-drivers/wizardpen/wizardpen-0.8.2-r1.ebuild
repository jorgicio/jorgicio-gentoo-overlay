# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit autotools

DESCRIPTION="A Linux/HAL/udev/X11 driver for most non-Wacom graphics pads"
HOMEPAGE="https://launchpad.net/wizardpen"
SRC_URI="https://launchpad.net/~doctormo/+archive/ubuntu/xorg-${PN}/+files/xserver-xorg-input-${PN}_${PV}-0ubuntu2.tar.gz"
S="${WORKDIR}/xorg-input-${P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-base/xorg-server"
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf
	default
}

src_configure(){
	econf \
		--with-udev-rules-dir=${EPREFIX}/$(get_libdir)/udev/rules.d
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst(){
	echo
	einfo "One you have installed this package, don't forget to"
	einfo "run the wizardpen-calibrate tool in order to"
	einfo "calibrate the device."
	echo
}

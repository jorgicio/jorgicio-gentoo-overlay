# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A Linux/HAL/udev/X11 driver for most non-Wacom graphics pads"
HOMEPAGE="https://launchpad.net/wizardpen"
SRC_URI="http://launchpad.net/${PN}/trunk/0.8/+download/xorg-input-${P}.tar.gz"
S="${WORKDIR}/xorg-input-${P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-base/xorg-server"
RDEPEND="${DEPEND}"

src_compile() {
	./autogen.sh || die "autogen filed"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
    exeinto /usr/lib/xorg/modules/drivers/
	doexe src/.libs/wizardpen_drv.so

	exeinto /usr/bin
	doexe calibrate/wizardpen-calibrate

	doman man/wizardpen.4

	newins ${FILESDIR}/wizardpen.fdi 45-wizardpen.fdi
}

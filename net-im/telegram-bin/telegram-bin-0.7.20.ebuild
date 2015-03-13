# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils versionator

RESTRICT="strip"

DESCRIPTION="Telegram Desktop Messenger (unofficial client) binary version"
HOMEPAGE="https://tdesktop.com/"
SRC_URI="
	amd64?	( https://updates.tdesktop.com/tlinux/tsetup.${PV}.tar.xz )
	x86?	( https://updates.tdesktop.com/tlinux32/tsetup32.${PV}.tar.xz )"

RESTRICT="mirror"
LICENSE="GPL-3"
IUSE="updater"
KEYWORDS="~x86 ~amd64"
INSTALL_DIR="/opt/telegram"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/Telegram"

src_install() {
    insinto "${INSTALL_DIR}"
	insopts -m755
    doins -r Telegram
	if use updater; then
		doins -r Updater
	fi
    make_wrapper "telegram" "${INSTALL_DIR}/Telegram"
    make_desktop_entry "telegram" "Telegram" "telegram" "Messenger"
}


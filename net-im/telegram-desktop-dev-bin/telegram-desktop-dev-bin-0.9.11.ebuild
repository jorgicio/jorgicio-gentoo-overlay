# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils pax-utils

RESTRICT="strip"

DESCRIPTION="Telegram Desktop Messenger (official client; dev channel) binary version"
HOMEPAGE="https://tdesktop.com/"
SRC_URI="
	amd64?	( http://updates.tdesktop.com/tlinux/tsetup.${PV}.dev.tar.xz )
	x86?	( http://updates.tdesktop.com/tlinux32/tsetup32.${PV}.dev.tar.xz )"

RESTRICT="mirror"
LICENSE="GPL-3"
IUSE="updater appindicator"
KEYWORDS="~x86 ~amd64"
INSTALL_DIR="/opt/telegram"
SLOT="0"
DEPEND="!net-im/telegram
		!net-im/telegram-bin"
RDEPEND="${DEPEND}
		appindicator? (
			x11-libs/gtk+:2
			dev-libs/libappindicator:2
		)"
S="${WORKDIR}/Telegram"

src_install() {
	pax-mark m Telegram
    insinto "${INSTALL_DIR}"
	insopts -m755
    doins -r Telegram 
	if use updater;then
		pax-mark m Updater
		doins -r Updater
	fi
    make_wrapper "telegram" "${INSTALL_DIR}/Telegram"
    make_desktop_entry "telegram" "Telegram" "telegram" "Messenger"
}


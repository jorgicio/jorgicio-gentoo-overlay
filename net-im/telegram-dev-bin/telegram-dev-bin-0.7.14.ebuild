# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils versionator

RESTRICT="strip"

DESCRIPTION="Telegram Desktop Messenger (unofficial client; dev channel) binary version"
HOMEPAGE="https://tdesktop.com/"
SRC_URI="
	amd64?	( https://updates.tdesktop.com/tlinux/tsetup.${PV}.dev.tar.xz )
	x86?	( https://updates.tdesktop.com/tlinux32/tsetup32.${PV}.dev.tar.xz )"

RESTRICT="mirror"
LICENSE="GPL-3"
IUSE=""
KEYWORDS="~x86 ~amd64"
INSTALL_DIR="/opt/telegram"
SLOT="0"
DEPEND="!net-im/telegram
		!net-im/telegram-bin"
RDEPEND="${DEPEND}"
S="${WORKDIR}/Telegram"

src_install() {
    insinto "${INSTALL_DIR}"
    doins -r Telegram Updater

    fperms 777 ${INSTALL_DIR}/Telegram
    fperms 777 ${INSTALL_DIR}/Updater

    make_wrapper "telegram" "${INSTALL_DIR}/Telegram"
    make_desktop_entry "telegram" "Telegram" "telegram" "Messenger"
}


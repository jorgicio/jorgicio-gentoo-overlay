# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/profile-sync-daemon/profile-sync-daemon-5.40.1.ebuild,v 1.2 2013/11/15 18:54:14 hasufell Exp $

EAPI=5

inherit eutils vcs-snapshot

DESCRIPTION="Symlinks and syncs browser profile dirs to RAM"
HOMEPAGE="https://wiki.archlinux.org/index.php/Profile-sync-daemon"
SRC_URI="https://github.com/graysky2/profile-sync-daemon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

RDEPEND="
	app-shells/bash
	net-misc/rsync
	systemd? ( sys-apps/systemd )"

src_install() {
	emake -j1 DESTDIR="${ED}" \
		install-openrc-all \
		$(usex systemd "install-systemd" "")

	fperms -x /etc/cron.hourly/psd-update
}

pkg_postinst() {
	elog "The cronjob is -x by default."
	elog "You might want to set it +x if you don't use"
	elog "the systemd provided \"psd-resync.timer\"."
}

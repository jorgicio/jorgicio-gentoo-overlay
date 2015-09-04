EAPI="5"

inherit eutils systemd vcs-snapshot

DESCRIPTION="Symlinks and syncs user specified dirs to RAM thus reducing HDD/SDD calls and speeding-up the system"
HOMEPAGE="https://wiki.archlinux.org/index.php/Anything-sync-daemon"
SRC_URI="http://repo-ck.com/source/${PN}/${P}.tar.xz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="systemd"

RDEPEND="
	app-shells/bash
	net-misc/rsync[xattr]
	virtual/cron
	systemd? ( sys-apps/systemd )
"

src_install() {
	install -Dm755 "common/${PN}" "${D}/usr/bin/${PN}"
	install -Dm644 "common/asd.conf" "${D}/etc/asd.conf"
	install -Dm755 "common/asd.cron.hourly" "${D}/etc/cron.hourly/asd-update"	
	dosym "/usr/bin/${PN}" "/usr/bin/asd"

	if use systemd ; then
		install -Dm644 "init/asd-resync.service" "${D}/usr/lib/systemd/system/asd-resync.service"
		install -Dm644 "init/asd-resync.timer" "${D}/usr/lib/systemd/system/asd-resync.timer"
		install -Dm644 "init/asd.service" "${D}/usr/lib/systemd/system/asd.service"
	else
		install -Dm755 ${FILESDIR}/asd "${D}/etc/init.d/asd"
	fi

	gzip -9 "doc/asd.1"
	install -g 0 -o 0 -Dm 0644 "doc/asd.1.gz" "${D}/usr/share/man/man1/${PN}.1.gz"
	install -g 0 -o 0 -Dm 0644 "doc/asd.1.gz" "${D}/usr/share/man/man1/asd.1.gz"
}

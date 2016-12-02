EAPI=6

inherit eutils systemd vcs-snapshot

DESCRIPTION="Symlinks and syncs user specified dirs to RAM thus reducing HDD/SDD calls and speeding-up the system"
HOMEPAGE="https://wiki.archlinux.org/index.php/Anything-sync-daemon"
SRC_URI="http://repo-ck.com/source/${PN}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="systemd"

RDEPEND="
	app-shells/bash
	net-misc/rsync[xattr]
	virtual/cron
	systemd? ( sys-apps/systemd )
"

src_compile(){
	emake DESTDIR="${D}"
}

src_install() {
	use systemd && emake DESTDIR="${D}" install-systemd-all
	use !systemd && emake DESTDIR="${D}" install-upstart-all
}

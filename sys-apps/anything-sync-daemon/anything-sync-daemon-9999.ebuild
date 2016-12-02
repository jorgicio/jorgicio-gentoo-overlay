EAPI=6

inherit eutils systemd vcs-snapshot git-r3

DESCRIPTION="Symlinks and syncs user specified dirs to RAM thus reducing HDD/SDD calls and speeding-up the system"
HOMEPAGE="https://wiki.archlinux.org/index.php/Anything-sync-daemon"
EGIT_REPO_URI="https://github.com/graysky2/anything-sync-daemon"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="systemd"

RDEPEND="
	app-shells/bash
	net-misc/rsync[xattr]
	virtual/cron
	systemd? ( sys-apps/systemd )
"

src_prepare(){
	epatch "${FILESDIR}/asd-openrc-support.patch"
	eapply_user
}


src_compile(){
	emake DESTDIR="${D}"
}

src_install() {
	use systemd && emake DESTDIR="${D}" install-systemd-all
	use !systemd && emake DESTDIR="${D}" install-upstart-all
}

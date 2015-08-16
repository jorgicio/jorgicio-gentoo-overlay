# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3 eutils

DESCRIPTION="Implementation of a web server-based terminal emulator. Fork of the now-unmantained Shell In A Box"
HOMEPAGE="https://github.com/shellinabox/shellinabox"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="v${PV}"

LICENSE="LGPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="systemd"

DEPEND="dev-libs/openssl[zlib]
		virtual/pam
		sys-devel/libtool"

RDEPEND="${DEPEND}
		systemd? ( sys-apps/systemd )"

src_prepare(){
	eautoreconf
}

src_install(){
	emake DESTDIR="${D}" install || die
	insinto "/etc/default"
	doins "${FILESDIR}"/${PN}
	if use systemd; then
		insinto /usr/lib/systemd/system
		newins "${FILESDIR}"/${PN}-systemd "${PN}@.service"
	else
		doinitd "${FILESDIR}"/${PN}d
	fi
}

pkg_postinst(){
	elog "USAGE: You can manually run the program with ${PN}d."
	elog "By default, it uses the port 4200, but you can specify it in the command line."
	elog "If you run it remotely, open a browser, and type:"
	elog "http://remoteIP:4200"
	elog "If running locally (with --localhost-only parameter), replace the remoteIP by localhost."
	if use systemd; then
		elog "You enabled the systemd USE-flag, so you can run it as an any other SystemD daemon."
	else
		elog "You can also run it as a daemon with /etc/init.d/${PN}d start, like any other."
	fi
}

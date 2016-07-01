# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils autotools systemd ${GIT_ECLASS}

DESCRIPTION="Implementation of a web server-based terminal emulator. Fork of the now-unmantained Shell In A Box"
HOMEPAGE="https://github.com/shellinabox/shellinabox"

if [[ ${PV} == *9999* ]];then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	KEYWORDS="~x86 ~amd64"
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
fi

LICENSE="LGPL-2.0"
SLOT="0"
IUSE="systemd"

DEPEND="dev-libs/openssl[zlib,kerberos]
		virtual/pam
		sys-devel/libtool"

RDEPEND="${DEPEND}
		systemd? ( sys-apps/systemd )"

src_prepare(){
	eautoreconf -i
	eapply_user
}

src_install(){
	emake DESTDIR="${D}" install || die
	if use systemd;then
		systemd_newunit "${FILESDIR}/${PN}.service" "${PN}@.service"
	else
		doinitd "${FILESDIR}"/${PN}d
		doconfd "${FILESDIR}/${PN}"
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

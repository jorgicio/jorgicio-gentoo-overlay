# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Ad blocker script"
HOMEPAGE="https://github.com/juankfree/hosty"
SRC_URI="${HOMEPAGE}/raw/5564c7fa544b4484bb23913359159e070c8abd47/${PN}"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	sys-apps/gawk
	net-misc/curl
	net-misc/wget
	app-admin/sudo
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install(){
	exeinto ${EPREFIX}/usr/bin
	doexe ${DISTDIR}/${PN}
}

pkg_postinst(){
	elog "Usage:"
	elog "First: ${PN} script must be run as root or using sudo."
	elog "Just run it to create a /etc/hosts with ad-blocking rules."
	elog "You can also create a whitelist stored in /etc/hosts.whitelist"
	elog "But if you want to use only your whitelists file, run:"
	elog "# ${PN} --all"
	elog "Restore /etc/hosts will be done at unmerging, or running:"
	elog "# ${PN} --restore"
	elog "Have fun!"
}

pkg_prerm(){
	elog "Restoring /etc/hosts file..."
	${EPREFIX}/usr/bin/${PN} --restore
}

pkg_postrm(){
	elog "/etc/hosts restored!"
}

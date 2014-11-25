# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Copy is a safe, synched cloud storage"
HOMEPAGE="http://copy.com"
SRC_URI="https://copy.com/install/linux/Copy.tgz -> ${P}.tgz"

LICENSE="Barracuda Networks Inc."
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore"
RDEPEND="${DEPEND}"
src_unpack(){
	unpack ${A}
	mv ${WORKDIR}/${PN} ${WORKDIR}/${P}
}

src_install(){
	local targetdir="/opt/copy"
	dodir "${targetdir}"
	insinto "${targetdir}"/
	if [[ "${ARCH}" == "amd64" ]];then
		doins -r ${S}/x86_64/*  || die "Install failed!"
	elif [[ "${ARCH}" == "x86" ]];then
		doins -r ${S}/x86/*  || die "Install failed!"
	fi
	fperms a+x "${targetdir}"/{CopyAgent,CopyConsole,CopyCmd}
	dosym "${targetdir}"/CopyAgent /opt/bin/copyagent
    dosym "${targetdir}"/CopyConsole /opt/bin/copyconsole
	dosym "${targetdir}"/CopyCmd /opt/bin/copycmd
	insinto /usr/share/applications/
	doins ${FILESDIR}/copy.desktop
	insinto /usr/share/pixmaps/
	doins ${FILESDIR}/copy.png
}

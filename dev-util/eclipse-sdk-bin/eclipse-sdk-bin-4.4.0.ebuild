# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils versionator

SR=R
RNAME="luna"

SRC_BASE="http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/${RNAME}/${SR}/eclipse-java-${RNAME}-${SR}-linux-gtk"

DESCRIPTION="Eclipse SDK"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz&r=1 -> eclipse-java-${RNAME}-${SR}-linux-gtk-x86_64-${PV}.tar.gz )
	x86? ( ${SRC_BASE}.tar.gz&r=1 -> eclipse-java-${RNAME}-${SR}-linux-gtk-${PV}.tar.gz )"

LICENSE="EPL-1.0"
SLOT="4.4"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	>=virtual/jdk-1.6
	x11-libs/gtk+:2"

S=${WORKDIR}/eclipse

src_install() {
	local dest=/opt/${PN}-${SLOT}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe eclipse

	dohtml -r about.html about_files epl-v10.html notice.html readme/*

	cp "${FILESDIR}"/eclipserc-bin-${SLOT} "${T}" || die
	cp "${FILESDIR}"/eclipse-bin-${SLOT} "${T}" || die
	sed "s@%SLOT%@${SLOT}@" -i "${T}"/eclipse{,rc}-bin || die

	insinto /etc
	newins "${T}"/eclipserc-bin-${SLOT} eclipserc-bin-${SLOT}

	newbin "${T}"/eclipse-bin-${SLOT} eclipse-bin-${SLOT}
	make_desktop_entry "eclipse-bin-${SLOT}" "Eclipse ${PV} (bin)" "${dest}/icon.xpm"
}

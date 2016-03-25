# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib unpacker

DESCRIPTION="Nautilus plugin for using the MEGA account with Megasync"
HOMEPAGE="http://mega.co.nz"
SRC_URI="
	x86? ( https://mega.nz/linux/MEGAsync/xUbuntu_14.04/i386/${PN}_${PV}_i386.deb )
	amd64? ( https://mega.nz/linux/MEGAsync/xUbuntu_14.04/amd64/${PN}_${PV}_amd64.deb )
"
RESTRICT="mirror"

LICENSE="MEGA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-misc/megasync[-nautilus]
		gnome-base/nautilus"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack ${A}
	unpack ./data.tar.xz
	rm -vr control.tar.gz data.tar.xz debian-binary usr/src
}

src_install(){
	insinto /
	doins -r usr
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils multilib unpacker

DESCRIPTION="MEGASync extension for the Nemo file browser"
HOMEPAGE="http://www.webupd8.org/2014/09/unofficial-megasync-nemo-extension.html"
SRC_URI="
	x86? ( https://github.com/hotice/webupd8/raw/master/${PN}_${PV}-0~webupd8~0_i386.deb )
	amd64? ( https://github.com/hotice/webupd8/raw/master/${PN}_${PV}-0~webupd8~0_amd64.deb )
"
RESTRICT="mirror"

LICENSE="custom"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	gnome-exnta/nemo
	net-misc/megasync[-nautilus]
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack "${A}"
	unpack ./data.tar.xz
	rm -rv control.tar.gz data.tar.xz debian-binary
}

src_install(){
	insinto /
	doins -r usr
}

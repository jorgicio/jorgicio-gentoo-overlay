# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

inherit ruby-fakegem

DESCRIPTION="Seriously Instant Screen-Grabbing"
HOMEPAGE="http://${PN}.com"
SRC_URI="https://github.com/${PN}/Gyazo-for-Linux/raw/master/src/${PN}.rb -> ${PN}"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xclip"

DEPEND="media-gfx/imagemagick
		xclip? ( x11-misc/xclip )"
RDEPEND="${DEPEND}"

each_ruby_install(){
	exeinto /usr/bin
	doexe ${DISTDIR}/${PN}
}

all_ruby_install(){
	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/${PN}.png
}

pkg_postinst(){
	elog "Usage: Just launch the Gyazo app, and then, drag your mouse to grab the screen."
}

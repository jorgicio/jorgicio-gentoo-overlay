# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

USE_RUBY="ruby23 ruby 24 ruby25"

inherit desktop ruby-single

DESCRIPTION="Seriously Instant Screen-Grabbing"
HOMEPAGE="http://gyazo.com"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/gyazo/Gyazo-for-Linux.git"
else
	SRC_URI="https://github.com/gyazo/Gyazo-for-Linux/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/Gyazo-for-Linux-${PV}"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="media-gfx/imagemagick"
RDEPEND="${DEPEND}
	x11-misc/xclip
"
BDEPEND="${RUBY_DEPS}"

src_install(){
	newbin src/${PN}.rb ${PN}
	domenu src/${PN}.desktop
	doicon icons/${PN}.png
}

pkg_postinst(){
	elog "Usage: Just launch the Gyazo app, and then, drag your mouse to grab the screen."
}

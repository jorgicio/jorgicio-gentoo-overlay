# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit eutils autotools python-r1

DESCRIPTION="Vanilla-compatible enhanced Doom engine, forked from Chocolate Doom"
HOMEPAGE="http://fabiangreffrath.github.io/crispy-doom"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/fabiangreffrath/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/fabiangreffrath/${PN}/archive/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/${PN}-${P}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
	media-libs/libpng:0
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-net
	media-libs/libsamplerate[sndfile]
"
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf
	default
}

src_install(){
	emake DESTDIR="${D}" install
	rm -rf /usr/share/man/man5/default.cfg.5 \
		/usr/share/man/man6/chocolate-{server,setup}.6
}

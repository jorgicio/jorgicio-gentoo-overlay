# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit autotools desktop python-any-r1

DESCRIPTION="Vanilla-compatible enhanced Doom engine, forked from Chocolate Doom"
HOMEPAGE="http://fabiangreffrath.github.io/crispy-doom"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fabiangreffrath/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/fabiangreffrath/${PN}/archive/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
	media-libs/libpng:0
	media-libs/sdl2-mixer[vorbis]
	media-libs/sdl2-net
	media-libs/libsamplerate[sndfile]
"
RDEPEND="${DEPEND}"

pkg_setup(){
	python-any-r1_pkg_setup
}

src_prepare(){
	sed -i -e "s#Exec=@PROGRAM_PREFIX@setup#Exec=@PROGRAM_PREFIX@doom-setup#" \
		src/setup/setup.desktop.in
	default_src_prepare
	eautoreconf
}

src_install(){
	default_src_install
	rm -rf "${ED%/}"/usr/share/man/man5/default.cfg.5 \
		"${ED%/}"/usr/share/man/man6/chocolate-{server,setup}.6 || die
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

DESCRIPTION="Cave Story, a platform-adventure game by Studio Pixel"
HOMEPAGE="http://www.cavestory.org http://www.humblebundle.com"
SRC_URI="CaveStoryPlus-linux.tar.gz"
RESTRICT="fetch strip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+bundled-libs"

DEPEND=""
RDEPEND="${DEPEND}
	!bundled-libs? (
		=media-libs/libsdl-1.2*
		virtual/glu
	)"

S="${WORKDIR}/CaveStory+"

pkg_nofetch() {
	echo
	elog "Download and place ${SRC_URI} in"
	elog "${DISTDIR}"
	echo
}

src_prepare() {
	# This will fix a crash caused by case being wrong
	rename -v Lounge lounge "${S}"/data/base/Stage/Lounge*
}

src_install() {
	local instdir="${GAMES_PREFIX_OPT}/${PN}"
	local exename="CaveStory+$(usex amd64 '_64' '')"
	local libdir="lib$(usex amd64 '64' '')"

	cat <<- EOF > "${PN}"
		#!/bin/sh

		CONFDIR=\${HOME}/.${PN}
		if [ ! -d "\${CONFDIR}" ]; then
		    mkdir -p "\${CONFDIR}"
		    ln -s "${instdir}/${libdir}"  "\${CONFDIR}/${libdir}"
		    ln -s "${instdir}/data" "\${CONFDIR}/data"
		fi
		cd "\${CONFDIR}"
		exec "${instdir}/${exename}"
	EOF
	dogamesbin "${PN}" || die

	insinto "${instdir}"
	use bundled-libs || rm -f ${libdir}/libSDL-1.2.so.0 ${libdir}/libGLU.so.1
	doins -r data ${libdir} || die

	exeinto "${instdir}" || die
	doexe "${exename}" || die

	make_desktop_entry "${PN}" "Cave Story+" "${instdir}/data/icon.bmp" "Game" || die

	prepgamesdirs
}

pkg_postinst() {
	echo
	einfo "To play, run: ${PN}"
	echo
}

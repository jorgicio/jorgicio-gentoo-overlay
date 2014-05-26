# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

MY_PN="CaveStory+"
DESCRIPTION="A platform-adventure game by Studio Pixel"
HOMEPAGE="http://www.nicalis.com/"

HIBPAGE="http://www.humblebundle.com"
SRC_URI="${PN//\+/plus}-linux-${PV}.tar.gz"

RESTRICT="fetch strip"
LICENSE="as-is"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="-bundled-libs"

RDEPEND="!bundled-libs? (
	    =media-libs/libsdl-1.2*
	    virtual/glu )
	 virtual/opengl"

S="${WORKDIR}/${MY_PN}"

GAMEDIR="${GAMES_PREFIX_OPT}/${PN}"

pkg_nofetch() {
	einfo ""
	einfo "Please buy and download \"${SRC_URI}\" from:"
	einfo "   ${HIBPAGE}"
	einfo "and move/link it to \"${DISTDIR}\""
	einfo ""
}

src_install() {
	# Data:
	insinto "${GAMEDIR}" || die "insinto \"${GAMEDIR}\" failed"
	find . -maxdepth 1 -mindepth 1 -type d ! -iname "lib*" -exec doins -r '{}' \+ || die "doins data failed"

	# Executable and libraries:
	exeinto "${GAMEDIR}" || die "exeinto \"${GAMEDIR}\" failed""newexe \"${PN}\" failed"
	newexe "${MY_PN}$(usex "amd64" "_64" "")" "${PN}" || die 
	use bundled-libs && ( doins -r "lib$(usex "amd64" "64" "")" || die "doins bundled libs failed" )

	# Make game wrapper:
	games_make_wrapper "${PN}" "./${PN}" "${GAMEDIR}" "$(usex "bundled-libs" "${GAMEDIR}/lib" "")" || die "games_make_wrapper \"./${PN}\" failed"

	# Install icon and desktop files:
	local icon="${PN}.png"
	newicon "data/icon.bmp" "${icon}" || die "newicon \"${icon}\" failed"
	make_desktop_entry "${PN}" "${MY_PN}" "/usr/share/pixmaps/${icon}" || die "make_desktop_entry failed"

	# Setting general permissions:
	prepgamesdirs
}

pkg_postinst() {
	echo ""
	games_pkg_postinst

	einfo "${MY_PN} savegames and configurations are stored in:"
	einfo "   \${HOME}/.local/share/${MY_PN}"
	echo ""
	einfo "To play, run:"
	einfo "   ${PN}"
	echo ""
}

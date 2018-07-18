# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6,7}} )

inherit distutils-r1

DESCRIPTION="An open source virtual assistent project for Linux distributions"
HOMEPAGE="https://dragon.computer"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/DragonComputer/${PN^}"
	KEYWORDS=""
else
	SRC_URI="https://github.com/DragonComputer/${PN^}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm ~ppc ~ppc64"
	S="${WORKDIR}/${PN^}-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="pulseaudio"

DEPEND="
	${PYTHON_DEPS}
	app-accessibility/julius[pulseaudio?]
	app-accessibility/festival
	dev-python/python-xlib[${PYTHON_USEDEP}]
	media-libs/portaudio
	media-libs/flac
	x11-libs/libnotify
	dev-python/wikipedia[${PYTHON_USEDEP}]
	dev-python/PyUserInput[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/speech_recognition[${PYTHON_USEDEP}]
	dev-python/nltk[${PYTHON_USEDEP}]
	dev-python/egenix-mx-base
	>=dev-python/httplib2-0.9.1[${PYTHON_USEDEP}]
	dev-python/pyaudio[${PYTHON_USEDEP}]
	dev-python/tinydb[${PYTHON_USEDEP}]
	net-misc/youtube-dl[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

pkg_postinst(){
	echo
	einfo "To use ${PN}, simply run the command \"${PN}\" (no quotes) on a terminal."
	einfo "To activate it, you must say HEY or WAKE UP."
	einfo "To deactivate it, say GO TO SLEEP."
	einfo "To silence it, say ENOUGH or SHUT UP."
	einfo "To kill it, say GOODBYE, BYE BYE or SEE YOU LATER."
	einfo "For more commands, go to the homepage: https://github.com/DragonComputer/${PN^}"
	einfo "If you're wondering, it's available in English only by the moment."
	echo
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )

inherit distutils-r1

DESCRIPTION="An open source virtual assistent project for Linux distributions"
HOMEPAGE="https://github.com/DragonComputer/Dragonfire"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm ~ppc ~ppc64"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="pulseaudio"

DEPEND="
	${PYTHON_DEPS}
	app-accessibility/julius[portaudio,pulseaudio?]
	app-accessibility/festival
	dev-python/python-xlib[${PYTHON_USEDEP}]
	media-libs/portaudio
	media-libs/flac
	x11-libs/libnotify
	dev-python/python-wikipedia[${PYTHON_USEDEP}]
	dev-python/PyUserInput[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/speech_recognition[${PYTHON_USEDEP}]
	dev-python/nltk[${PYTHON_USEDEP}]
	dev-python/egenix-mx-base
	>=dev-python/httplib2-0.9.1[${PYTHON_USEDEP}]
	dev-python/pyaudio[${PYTHON_USEDEP}]
	dev-python/tinydb[${PYTHON_USEDEP}]
	net-misc/youtube_dl[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

pkg_postinst(){
	echo
	elog "To use ${PN}, simply run the command \"${PN}\" (no quotes) on a terminal."
	elog "To activate it, you must say HEY or WAKE UP."
	elog "To deactivate it, say GO TO SLEEP."
	elog "To silence it, say ENOUGH or SHUT UP."
	elog "To kill it, say GOODBYE, BYE BYE or SEE YOU LATER."
	elog "For more commands, go to the homepage: ${HOMEPAGE}"
	elog "If you're wondering, it's available in English only by the moment."
	echo
}

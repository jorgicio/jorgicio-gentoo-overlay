# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
inherit distutils-r1

DESCRIPTION="Google-powered speech recognition for Python"
HOMEPAGE="https://github.com/Uberi/speech_recognition"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm ~ppc ~ppc64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="sphinx"

DEPEND="
	${PYTHON_DEPS}
	dev-python/pyaudio[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	sphinx? ( app-accessibility/pocketsphinx[${PYTHON_USEDEP}] )
	amd64? ( media-libs/flac )
	python_targets_python2_7? ( dev-python/monotonic[${PYTHON_USEDEP}] )
"
RDEPEND="${DEPEND}"

pkg_postinst(){
	if use sphinx;then
		echo
		elog "If you're using Sphinx, you may notice US English is the language by default."
		elog "If you want to install more languages, lots of them are available, but"
		elog "International French and Mandarin Chinese are not included because their"
		elog "files are too large, so you may install them manually."
		echo
	fi
}

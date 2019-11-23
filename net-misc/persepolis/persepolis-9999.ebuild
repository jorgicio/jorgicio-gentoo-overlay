# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 xdg-utils

DESCRIPTION="Qt-based download manager and frontend for aria2 with lots of features."
HOMEPAGE="https://persepolisdm.github.io"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/persepolisdm/${PN}.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/persepolisdm/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="gtk"

DEPEND="
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP},svg,gui,network]
	dev-python/setproctitle[${PYTHON_USEDEP}]
	media-sound/pulseaudio
	net-misc/aria2
	net-misc/youtube-dl[${PYTHON_USEDEP}]
	x11-libs/libnotify
	x11-themes/sound-theme-freedesktop
"
RDEPEND="${DEPEND}
	gtk? ( x11-themes/adwaita-qt )
"
BDEPEND="${PYTHON_DEPS}"

src_prepare(){
	sed -i -e "/persepolis\.1\.gz/d" setup.py
	distutils-r1_src_prepare
}

src_install(){
	distutils-r1_src_install
	doman man/${PN}.1
}

pkg_postinst(){
	xdg_desktop_database_update
	echo
	elog "Thank you for installing Persepolis Download Manager."
	elog "You can also integrate it with your favorite web browser."
	elog "Install the extension required to do so. Available for"
	elog "Firefox, Google Chrome/Chromium and Opera (and based ones)."
	echo
}

pkg_postrm(){
	xdg_desktop_database_update
}

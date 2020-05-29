# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

DESCRIPTION="macOS Mojave-like theme for KDE Plasma"
HOMEPAGE="https://github.com/vinceliuice/McMojave-kde"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	MY_PN="McMojave-kde"
	MY_PV="435fb0a62dad9dcd2553e45bda5b282aa5113d9e"
	MY_P="${MY_PN}-${MY_PV}"
	SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="kvantum"

DEPEND="
	kde-plasma/plasma-desktop
	kvantum? ( x11-themes/kvantum )"
RDEPEND="${DEPEND}"

src_prepare() {
	if use !kvantum; then
		sed -i -e "/KVANTUM_DIR/d" install.sh || die
	fi
	sed -i -e 's#_DIR="/usr#_DIR="${DESTDIR}/usr#g' install.sh || die
	sed -i -e 's#$UID#$PUID#' install.sh || die
	default
}

src_install() {
	PUID=0 DESTDIR="${ED}" ./install.sh || die
}

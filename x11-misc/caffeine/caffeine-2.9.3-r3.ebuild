# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
PLOCALES="ar bg bs ca cs da de el en_GB eo es eu fi fr gl he hu it ja lt ms nl no pl pt_BR pt ro ru sk sv th tr uk vi xh zh_TW"

inherit distutils-r1 gnome2-utils l10n

DESCRIPTION="Stop the desktop from becoming idle in full-screen mode"
HOMEPAGE="https://launchpad.net/caffeine"
SRC_URI="https://launchpad.net/~caffeine-developers/+archive/ubuntu/ppa/+files/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	dev-libs/libappindicator
	dev-python/ewmh[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	x11-misc/xdg-utils
"
DEPEND="sys-devel/gettext"

DOCS="COPYING* README VERSION"

S="${WORKDIR}/${PN}"

python_prepare_all() {
	# Support python-3.4
	epatch "${FILESDIR}/${P}-python3.4-support.patch"

	# Remove non-ASCII characters
	sed -i \
		-e 's/\xc2\xa9/(c)/' \
		caffeine{,-indicator} || die "fixing the executable file failed"

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	# Remove disabled linguas
	rm_loc() {
		if [[ -e "${ED}/usr/share/locale/${1}" ]]; then
			rm -r "${ED}/usr/share/locale/${1}" || die
		fi
	}
	l10n_for_each_disabled_locale_do rm_loc
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

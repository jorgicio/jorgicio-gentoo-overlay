# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{3,4,5} )
inherit distutils-r1 gnome2-utils

DESCRIPTION="Prevent desktop idleness in full-screen mode"
HOMEPAGE="https://launchpad.net/caffeine"
SRC_URI="https://launchpad.net/~caffeine-developers/+archive/ubuntu/ppa/+files/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
LANGS="ar bg bs ca cs da de el en_GB eo es eu fi fr gl he hu it ja lt ms nl no pl pt_BR pt ro ru sk sv th tr uk vi xh zh_TW"
IUSE=""

for lang in ${LANGS}; do
	IUSE+=" linguas_${lang}"
done

DEPEND="
	dev-libs/libappindicator
	dev-perl/Net-DBus
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/python3-xlib[${PYTHON_USEDEP}]
	x11-apps/xprop
	x11-apps/xset
	x11-apps/xwininfo
"
RDEPEND="${DEPEND}"

DOCS="COPYING* README VERSION"

S="${WORKDIR}/${PN}"

_clean_up_locales() {
	einfo "Cleaning up locales..."
	for lang in ${LANGS}; do
		use "linguas_${lang}" && {
			einfo "- keeping ${lang}"
			continue
		}
		rm -Rf "${ED}"/usr/share/locale/"${lang}" || die
	done
}

python_prepare_all() {
	# Show desktop entry everywhere
	sed -i \
		-e '/^OnlyShowIn/d' \
		share/applications/caffeine-indicator.desktop \
		|| die "fixing .desktop file failed"
	# Remove non-ASCII characters
	sed -i \
		-e 's/'$'\u00C2\u00A9''/(C)/' \
		caffeine{,-indicator} || die "fixing the executable file failed"
	# Add MATE support
	epatch "${FILESDIR}/${P}-mate-support.patch"
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_prepare_all

	_clean_up_locales
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

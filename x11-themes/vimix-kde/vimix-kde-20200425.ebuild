# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Flat Material Design-like theme for KDE Plasma"
HOMEPAGE="https://github.com/vinceliuice/vimix-kde"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	COMMIT="8ecc8db7657ed9c28aeeaf0e19dc9c7304b1e437"
	SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="kvantum sddm"

DEPEND="
	kde-plasma/plasma-desktop:5
	kvantum? ( x11-themes/kvantum )
	sddm? ( x11-misc/sddm )"
RDEPEND="${DEPEND}"

src_prepare() {
	use !kvantum && sed -i -e "/KVANTUM/d" install.sh
	sed -i -e "s#/usr#\${DESTDIR}/usr#g" install.sh
	sed -i -e "s#/usr#\${DESTDIR}/usr#g" sddm/install.sh
	default
}

src_install() {
	DESTDIR="${ED}" ./install.sh || die
	if use sddm; then
		mkdir -p "${ED}"/usr/share/sddm/themes
		DESTDIR="${ED}" sh sddm/install.sh || die
	fi
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Adapta KDE customization"
HOMEPAGE="https://git.io/adapta-kde"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/${PN}"
else
	SRC_URI="https://github.com/PapirusDevelopmentTeam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="kvantum"

DEPEND="kde-plasma/plasma-desktop:5"
RDEPEND="${DEPEND}
	kvantum? ( x11-themes/kvantum )"

src_install() {
	THEME="aurorae color-schemes konsole plasma wallpapers yakuake"
	use kvantum && THEME+=" Kvantum"
	DESTDIR="${ED}" THEMES="${THEME}" default
}

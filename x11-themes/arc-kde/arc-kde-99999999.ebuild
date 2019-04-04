# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Arc KDE customization"
HOMEPAGE="https://git.io/arc-kde"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/${PN}.git"
else
	SRC_URI="https://github.com/PapirusDevelopmentTeam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"
IUSE="konsole kvantum"

RDEPEND="
	konsole? ( kde-apps/konsole )
	kvantum? ( x11-themes/kvantum )
"

pkg_postinst(){
	if use !kvantum; then
		echo
		elog "This theme optionally supports and recommends x11-themes/kvantum"
		elog "for a better eye-candy experience."
		echo
	fi
}

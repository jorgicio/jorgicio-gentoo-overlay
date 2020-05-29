# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Moka is a stylized Linux desktop icon set"
HOMEPAGE="https://snwh.org/moka"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/snwh/moka-icon-theme.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/snwh/moka-icon-theme/archive/v${PV}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND="x11-themes/faba-icon-theme"
RDEPEND="${DEPEND}"

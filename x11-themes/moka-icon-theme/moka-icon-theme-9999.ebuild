# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils autotools

DESCRIPTION="Moka is a stylized Linux desktop icon set, and the titular icon theme of the Moka Project. They are designed to be clear, simple and consistent."
HOMEPAGE="http://snwh.org/moka"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/snwh/moka-icon-theme.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/snwh/moka-icon-theme/archive/v${PV}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm ~amd64 ~x86"
fi

LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND="x11-themes/faba-icon-theme"
RDEPEND="${DEPEND}"

src_prepare(){
	default
	eautoreconf
}

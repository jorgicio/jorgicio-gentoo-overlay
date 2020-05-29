# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Monochrome variant of Faba Icon Theme"
HOMEPAGE="http://snwh.org"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/moka-project/faba-mono-icons.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/moka-project/faba-mono-icons/archive/v${PV}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="x11-themes/faba-icon-theme"
RDEPEND="${DEPEND}"

src_prepare(){
	default
	eautoreconf
}

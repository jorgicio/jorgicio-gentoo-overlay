# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit meson

DESCRIPTION="Faba is a sexy and modern icon theme with Tango influences."
HOMEPAGE="http://snwh.org/moka#faba-icon-theme"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/snwh/faba-icon-theme.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/snwh/faba-icon-theme/archive/v${PV}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_postinst(){
	elog "Hi! Thanks for prefering Faba Icons."
	elog "If you want to use some other variants, such as Moka, "
	elog "please, install this theme first. Thanks."
}

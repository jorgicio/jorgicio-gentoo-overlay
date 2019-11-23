# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )

inherit distutils-r1

DESCRIPTION="Tool to automatically purge old trashed files"
HOMEPAGE="https://bneijt.nl/pr/autotrash"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/bneijt/${PN}.git"
else
	SRC_URI="https://github.com/bneijt/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-python/nose[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

pkg_postinst(){
	echo ""
	einfo "In order to purge automatically old trashed files, you may"
	einfo "need to add the ${PN} binary to a crontab."
	einfo "See https://github.com/bneijt/${PN}#configuration for more info."
	echo ""
}

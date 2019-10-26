# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fast URL matcher library"
HOMEPAGE="https://github.com/clbr/urlmatch"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm ~arm64 ~x86 ~amd64"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE=""

DEPEND="
	sys-devel/libtool
"
RDEPEND="${DEPEND}"

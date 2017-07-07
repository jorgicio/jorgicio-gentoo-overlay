# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils

DESCRIPTION="libsass command line driver"
HOMEPAGE="https://github.com/sass/sassc"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="https://github.com/sass/sassc/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="=dev-libs/libsass-${PV}"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	eautoreconf
}

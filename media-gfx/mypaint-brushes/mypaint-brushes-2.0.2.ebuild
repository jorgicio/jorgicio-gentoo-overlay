# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Default MyPaint Brushes (2.x)"
HOMEPAGE="https://github.com/mypaint/mypaint-brushes"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="2.0"
KEYWORDS="~alpha ~amd64 ~arm64 ~hppa ~ia64 ~ppc64  ~x86"
IUSE=""

DEPEND=">=media-libs/libmypaint-1.5"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}

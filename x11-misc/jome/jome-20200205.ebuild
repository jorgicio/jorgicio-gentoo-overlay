# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic

COMMIT="62c1fb22f7650db6fb963d6a39408c3d97faf1c0"

DESCRIPTION="An emoji picker desktop application"
HOMEPAGE="https://github.com/eepp/jome"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=dev-libs/boost-1.58:0=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${COMMIT}"

pkg_pretend() {
	! test-flag-CXX -std=c++14 \
		&& die "Your compiler does not support C++14."
}

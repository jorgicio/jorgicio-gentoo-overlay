# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A simple & lightweight desktop-agnostic Qt file archiver"
HOMEPAGE="https://github.com/lxqt/lxqt-archiver"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtx11extras:5
	x11-libs/libfm-qt
	dev-qt/qtcore:5
	dev-libs/json-glib
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-util/lxqt-build-tools-0.5.0"

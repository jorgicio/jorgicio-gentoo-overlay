# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION="3.0.2"

inherit cmake-utils

DESCRIPTION="Re-connectable secure remote shell"
HOMEPAGE="https://mistertea.github.io/EternalTerminal"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/MisterTea/EternalTerminal"
else
	MY_PN="EternalTerminal-et"
	MY_P="${MY_PN}-v${PV}"
	SRC_URI="https://github.com/MisterTea/EternalTerminal/archive/et-v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="utempter"

DEPEND="
	dev-libs/libsodium
	dev-cpp/gflags
	dev-libs/protobuf
	app-arch/unzip
	net-misc/wget
	utempter? ( sys-libs/libutempter )
"
RDEPEND="${DEPEND}"

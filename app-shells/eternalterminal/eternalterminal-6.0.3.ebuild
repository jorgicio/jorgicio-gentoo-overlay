# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Re-connectable secure remote shell"
HOMEPAGE="https://eternalterminal.dev"

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
IUSE="selinux utempter"

DEPEND="
	dev-libs/libsodium
	dev-cpp/gflags
	dev-libs/protobuf
	app-arch/unzip
	net-misc/wget
	selinux? ( sys-libs/libselinux )
	utempter? ( sys-libs/libutempter )
"
RDEPEND="${DEPEND}"

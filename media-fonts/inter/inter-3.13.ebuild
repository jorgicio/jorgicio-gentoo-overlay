# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="The Inter font family"
HOMEPAGE="https://rsms.me/inter/"
SRC_URI="https://github.com/rsms/${PN}/releases/download/v${PV}/Inter-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~x86-linux ~x64-macos"

DEPEND="app-arch/unzip"

S=${WORKDIR}
FONT_S="${S}/Inter"
FONT_SUFFIX="otf"

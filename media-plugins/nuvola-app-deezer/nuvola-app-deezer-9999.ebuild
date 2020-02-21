# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Deezer integration for Nuvola Player"
HOMEPAGE="https://github.com/tiliado/nuvola-app-deezer"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"

RDEPEND="media-sound/nuvolaruntime"
DEPEND="${RDEPEND}
	media-libs/nuvolasdk
	media-gfx/scour"

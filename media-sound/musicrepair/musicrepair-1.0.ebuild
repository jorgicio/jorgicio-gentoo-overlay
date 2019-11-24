# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/kalbhor/MusicRepair/..."
EGO_VENDOR=(
	"github.com/bogem/id3v2 v1.1.1"
	"github.com/headzoo/surf v1.0.0"
	"github.com/zmb3/spotify 869e03dbd8b0"
	"golang.org/x/oauth2 5d9234df094c github.com/golang/oauth2"
)

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Fixes music metadata and adds album art"
HOMEPAGE="https://github.com/kalbhor/MusicRepair"
SRC_URI="https://github.com/kalbhor/MusicRepair/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND="
	>=dev-lang/go-1.12
	dev-go/go-net
	dev-go/go-text"

src_install() {
	default
	dobin MusicRepair
	dosym MusicRepair /usr/bin/${PN}
}

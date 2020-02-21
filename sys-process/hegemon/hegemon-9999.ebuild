# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
chan-0.1.21
chan-signal-0.3.1
regex-1.0.1
termion-1.5.1
systemstat-0.1.3
sensors-0.2.0
"

inherit cargo git-r3

DESCRIPTION="A modular system monitor written in Rust"
HOMEPAGE="https://github.com/p-e-w/hegemon"
SRC_URI="$(cargo_crate_uris ${CRATES})"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/lm-sensors"
RDEPEND="${DEPEND}"
BDEPEND=">=virtual/rust-1.26.0"

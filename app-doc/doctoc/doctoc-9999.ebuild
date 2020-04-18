# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Generates a TOC for Markdown files inside for a git-based repository"
HOMEPAGE="https://github.com/thlorenz/doctoc"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="network-sandbox"

DEPEND="net-libs/nodejs[npm]"
RDEPEND="${DEPEND}"

src_install(){
	npm install -g --prefix="${ED}/usr" ${PN} || die "Installation failed"
}

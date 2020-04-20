# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

DESCRIPTION="Website crawler for your desktop"
HOMEPAGE="http://www.screamingfrog.co.uk/seo-spider/"
SRC_URI="https://download.screamingfrog.co.uk/products/seo-spider/${P/-/_}_all.deb"

LICENSE="screamingfrogseospider-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"

DOCS="usr/share/doc/${PN}/changelog.gz usr/share/doc/${PN}/copyright"

src_unpack(){
	unpack_deb ${A}
}

src_prepare() {
	mv usr/share/${PN}/tmp jre || die
	default
}

src_install(){
	mkdir -p "${D}/usr/share"
	dobin usr/bin/${PN}
	cp -r usr/share/{applications,icons,mime,${PN}} "${D}/usr/share"
	local jrefile
	if use amd64; then
		jrefile="jre64"
	elif use x86; then
		jrefile="jre32"
	fi
	tar xf jre/${jrefile}.tar.gz -C "${D}"/usr/share/${PN}
	doman usr/share/man/man1/${PN}.1.gz
	default
}

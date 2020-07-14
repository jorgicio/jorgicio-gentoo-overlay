# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker xdg

DESCRIPTION="Website crawler for your desktop"
HOMEPAGE="https://www.screamingfrog.co.uk/seo-spider/"
SRC_URI="https://download.screamingfrog.co.uk/products/seo-spider/${P/-/_}_all.deb"

LICENSE="screamingfrogseospider"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"
IUSE="system-java"

RDEPEND="system-java? ( >=virtual/jre-11 )"

S="${WORKDIR}"

DOCS="usr/share/doc/${PN}/changelog usr/share/doc/${PN}/copyright"

src_unpack(){
	unpack_deb ${A}
}

src_prepare() {
	if use system-java; then
		rm -rf usr/share/${PN}/jre
		sed -i -e "/JRE_HOME/d" usr/bin/${PN}
		sed -i -e "s|\${JAVA_PATH}/||" usr/bin/${PN}
	fi
	gunzip usr/share/doc/${PN}/changelog.gz
	gunzip usr/share/man/man1/${PN}.1.gz
	default
}

src_install(){
	mkdir -p "${ED%/}/usr/share"
	dobin usr/bin/${PN}
	cp -r usr/share/{applications,icons,mime,${PN}} "${ED%/}/usr/share"
	doman usr/share/man/man1/${PN}.1
	pax-mark m "${ED%/}"/usr/bin/${PN}
	default
}

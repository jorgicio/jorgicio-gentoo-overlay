# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Statically typed programming language for modern multiplatform applications"
HOMEPAGE="https://kotlinlang.org/"
SRC_URI="https://github.com/JetBrains/kotlin/releases/download/v${PV}/kotlin-compiler-${PV}.zip"

LICENSE="Apache-2.0 BSD MIT NPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="app-shells/bash
	>=virtual/jdk-1.8
	>=virtual/jre-1.8"

S="${WORKDIR}/kotlinc"

src_install() {
	rm bin/*.bat || die
	dodoc license/NOTICE.txt
	rm -r license || die

	mkdir -p "${D}/opt/${PN/-bin}"
	cp -r . "${D}/opt/${PN/-bin}"
	for i in bin/*; do
		dosym "${EROOT}/opt/${PN/-bin}/$i" "/usr/bin/${i//*\/}"
	done
}

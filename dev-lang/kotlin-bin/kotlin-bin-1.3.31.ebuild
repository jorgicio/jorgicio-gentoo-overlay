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

	insinto "/opt/${PN}"
	doins -r *
	for i in bin/*; do
		fperms +x "/opt/${PN}/$i"
		dosym "${EROOT}/opt/${PN}/$i" "/usr/bin/${i//*\/}"
	done
}

# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="An SRE framework developed by the NSA Research Directorate"
HOMEPAGE="https://ghidra-sre.org"
PUBLIC_DATE="20190325"
SRC_URI="https://ghidra-sre.org/${P/-/_}_PUBLIC_${PUBLIC_DATE}.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+python +server"
S="${WORKDIR}/${P/-/_}"
RESTRICT="mirror strip"

DEPEND="app-shells/bash"
RDEPEND="${DEPEND}
	|| (
		virtual/jdk:11
		virtual/jre:11
	)
	python? ( ${PYTHON_DEPS} )
	server? ( virtual/pam )
"

QA_PRESTRIPPED="/opt/ghidra/docs/GhidraClass/ExerciseFiles/Advanced/sharedReturn"

src_install(){
	insinto /opt/${PN}
	doins -r *
	fperms -R a+r "${EPREFIX}/opt/${PN}"
	dobin "${FILESDIR}/${PN}"
	BINARIES="
		support/analyzeHeadless
		support/buildGhidraJar
		support/convertStorage
		support/dumpGhidraThreads
		support/ghidraDebug
		support/launch.sh
		support/pythonRun
		support/sleigh
		ghidraRun
		server/ghidraSvr
		server/svrAdmin
		server/svrInstall
		server/svrUninstall
	"
	for f in ${BINARIES}; do
		fperms +x "${EPREFIX}/opt/${PN}/${f}"
	done
}

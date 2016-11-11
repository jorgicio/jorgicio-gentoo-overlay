# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="Generates API part of libqtelegram automatically"
HOMEPAGE="https://github.com/Aseman-Land/libqtelegram-code-generator"
LICENSE="GPL-2"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	GH_REF="29462b49f094e88d2d65efeb6b98254d814294fc"
	SRC_URI="${HOMEPAGE}/archive/${GH_REF}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/${PN}-${GH_REF}"
fi

SLOT="0"

DEPEND="dev-qt/qtcore:5"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5 libqtelegram-generator.pro
}

src_install(){
	exeinto /usr/libexec
	doexe libqtelegram-generator
	einstalldocs
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Fight Flash Fraud, or Fight Fake Flash"
HOMEPAGE="http://oss.digirati.com.br/f3/"
EGIT_REPO_URI="https://github.com/AltraMayor/${PN}"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AltraMayor/${PN}"
	KEYWORDS=""
	IUSE="+extras"
else
	SRC_URI="https://github.com/AltraMayor/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	IUSE="experimental"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

CDEPEND="
	sys-block/parted
	virtual/udev
"
DEPEND="${CDEPEND}"
RDEPEND="${DEPEND}"

src_compile(){
	export CFLAGS="${CFLAGS} -fgnu89-inline"
	emake all
	if [[ ${PV} == *9999* ]];then
		use extras && emake extra
	else
		use experimental && emake experimental
	fi
}

src_install() {
	emake install PREFIX="${D}/usr/"
	if [[ ${PV} == *9999* ]];then
		use extras && emake install-extra PREFIX="${D}/usr/"
	else
		use experimental && emake install-experimental PREFIX="${D}/usr/"
	fi
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop cmake xdg

MY_PN="MultiMC5"
MY_P="${MY_PN}-${PV}"
QUAZIP_VER="3"
LIBNBTPLUSPLUS_VER="0.6.1"

DESCRIPTION="An advanced Qt5-based open-source launcher for Minecraft"
HOMEPAGE="https://multimc.org"
BASE_URI="https://github.com/MultiMC"
SRC_URI="
	${BASE_URI}/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${BASE_URI}/libnbtplusplus/archive/multimc-${LIBNBTPLUSPLUS_VER}.tar.gz -> ${P}-libnbtplusplus-${LIBNBTPLUSPLUS_VER}.tar.gz
	${BASE_URI}/quazip/archive/multimc-${QUAZIP_VER}.tar.gz -> ${P}-quazip-${QUAZIP_VER}.tar.gz"

KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"

COMMON_DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qttest:5
	dev-qt/qtxml:5"

DEPEND="
	${COMMON_DEPEND}"

RDEPEND="
	${COMMON_DEPEND}
	sys-libs/zlib
	>=virtual/jre-1.8.0
	virtual/opengl
	x11-libs/libXrandr"

BDEPEND=">=virtual/jdk-1.8.0"

PATCHES=(
	"${FILESDIR}/fortify-fix-2.patch"
	"${FILESDIR}/modern-java-check.patch"
	"${FILESDIR}/${PN}-fix-clang-10.patch"
)

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}" || die
	local i list=( libnbtplusplus-${LIBNBTPLUSPLUS_VER} quazip-${QUAZIP_VER} )
	for i in "${list[@]}"; do
		tar xf "${DISTDIR}/${P}-${i}.tar.gz" --strip-components 1 -C libraries/${i%-*} || die
	done
}

src_prepare(){
	cd libraries/quazip
	eapply "${FILESDIR}/quazip-fix-build-with-qt-511.patch"
	cd ../..
	cmake_src_prepare
}

src_configure(){
	local mycmakeargs=(
		-DMultiMC_LAYOUT=lin-system
	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
	domenu application/package/linux/multimc.desktop
	doicon -s scalable application/resources/multimc/scalable/multimc.svg
}

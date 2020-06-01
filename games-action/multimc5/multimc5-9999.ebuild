# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop git-r3 xdg

DESCRIPTION="An advanced Qt5-based open-source launcher for Minecraft"
HOMEPAGE="https://multimc.org"
EGIT_REPO_URI="https://github.com/MultiMC/MultiMC5"

LICENSE="Apache-2.0"
SLOT="0"

COMMON_DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qttest:5
	dev-qt/qtxml:5
"
DEPEND="
	${COMMON_DEPEND}"

RDEPEND="
	${COMMON_DEPEND}
	sys-libs/zlib
	>=virtual/jre-1.8.0
	virtual/opengl
	x11-libs/libXrandr
"

BDEPEND=">=virtual/jdk-1.8.0"

PATCHES=(
	"${FILESDIR}/fortify-fix-2.patch"
	"${FILESDIR}/modern-java-check.patch"
)

src_prepare(){
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

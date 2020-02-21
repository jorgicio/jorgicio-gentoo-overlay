# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils desktop

DESCRIPTION="A PSP emulator written in C++"
HOMEPAGE="https://www.ppsspp.org/"
SRC_URI="
	https://github.com/hrydgard/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	!system-ffmpeg? ( https://github.com/hrydgard/ppsspp-ffmpeg/archive/90701640c7f458461310b54e7d4041230e2d5d5a.tar.gz -> ${P}-ffmpeg.tar.gz )
	https://github.com/hrydgard/ppsspp-lang/archive/bfc3a511f60e84de4d49170e2c442ac36b09cdfd.tar.gz -> ${P}-assets_lang.tar.gz
	https://github.com/hrydgard/pspautotests/archive/2970fbcc23c258ebc03bba922926003fe37555e5.tar.gz -> ${P}-pspautotests.tar.gz
	https://github.com/hrydgard/minidx9/archive/7751cf73f5c06f1be21f5f31c3e2d9a7bacd3a93.tar.gz -> ${P}-dx9sdk.tar.gz
	https://github.com/hrydgard/glslang/archive/f9d08a25fbe17e0677a89d398f4d7f232339c3f9.tar.gz -> ${P}-ext_glslang.tar.gz
	https://github.com/Kingcom/armips/archive/7885552b208493a6a0f21663770c446c3ba65576.tar.gz -> ${P}-ext_armips.tar.gz
	https://github.com/Kingcom/tinyformat/archive/e2eb06339c21d15db13cd8aa44a4b287970124f4.tar.gz -> ${P}-ext_armips_ext_tinyformat.tar.gz
	https://github.com/KhronosGroup/SPIRV-Cross/archive/a1f7c8dc8ea2f94443951ee27003bffa562c1f13.tar.gz -> ${P}-ext_SPIRV-Cross.tar.gz
	https://github.com/Tencent/rapidjson/archive/73063f5002612c6bf64fe24f851cd5cc0d83eef9.tar.gz -> ${P}-ext_rapidjson.tar.gz
	https://github.com/discordapp/discord-rpc/archive/3d3ae7129d17643bc706da0a2eea85aafd10ab3a.tar.gz -> ${P}-ext_discord-rpc.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="headless libav +qt5 sdl +system-ffmpeg"
REQUIRED_USE="!qt5? ( sdl )"

RDEPEND="
	app-arch/snappy:=
	dev-libs/libzip:=
	media-libs/glew:=
	sys-libs/zlib:=
	virtual/opengl
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtopengl:5
		dev-qt/qtwidgets:5
		!sdl? ( dev-qt/qtmultimedia:5 )
	)
	sdl? ( media-libs/libsdl2 )
	system-ffmpeg? (
		!libav? ( media-video/ffmpeg:= )
		libav? ( media-video/libav:= )
	)
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.4-O2.patch
	"${FILESDIR}"/${PN}-1.5.4-stdint-gcc-10.patch
)

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}" || die
	local i list=( assets_lang pspautotests dx9sdk ext_glslang ext_armips ext_SPIRV-Cross ext_armips_ext_tinyformat ext_rapidjson ext_discord-rpc )
	if ! use system-ffmpeg; then
		list+=( ffmpeg )
	fi
	for i in "${list[@]}"; do
		tar xf "${DISTDIR}/${P}-${i}.tar.gz" --strip-components 1 -C "${i//_//}" || die "Failed to unpack ${P}-${i}.tar.gz"
	done
}

src_prepare() {
	if ! use system-ffmpeg; then
		sed -i -e "s#-O3#-O2#g;" "${S}"/ffmpeg/linux_*.sh || die
	fi
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DHEADLESS=$(usex headless)
		-DUSING_QT_UI=$(usex qt5)
		$(cmake-utils_use_find_package sdl SDL2)
		-DUSE_SYSTEM_FFMPEG=$(usex system-ffmpeg)
	)
	cmake-utils_src_configure
}

src_install() {
	use headless && dobin "${BUILD_DIR}/PPSSPPHeadless"
	insinto /usr/share/"${PN}"
	doins -r "${BUILD_DIR}/assets"
	dobin "${BUILD_DIR}/PPSSPP$(usex qt5 Qt SDL)"
	local i
	for i in 16 24 32 48 64 96 128 256 512 ; do
		doicon -s ${i} "icons/hicolor/${i}x${i}/apps/${PN}.png"
	done
	make_desktop_entry "PPSSPP$(usex qt5 Qt SDL)" "PPSSPP ($(usex qt5 Qt SDL))" "${PN}" "Game"
}

pkg_postinst() {
	if use system-ffmpeg; then
		ewarn "system-ffmpeg USE flag is enabled, some bugs might arise due to it."
		ewarn "See https://github.com/hrydgard/ppsspp/issues/9026 for more informations."
	fi
}

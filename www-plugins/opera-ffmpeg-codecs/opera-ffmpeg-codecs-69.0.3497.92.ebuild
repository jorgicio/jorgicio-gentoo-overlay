# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit check-reqs chromium-2 eutils flag-o-matic multilib ninja-utils python-any-r1 toolchain-funcs

DESCRIPTION="ffmpeg extra codecs for Opera (i.e. mp3 and h.264)"
HOMEPAGE="http://ffmpeg.org"
SRC_URI="https://commondatastorage.googleapis.com/chromium-browser-official/chromium-${PV}.tar.xz"

RESTRICT="bindist"

LICENSE="LGPL-2.1 BSD"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-util/gn
	virtual/ffmpeg
	dev-lang/yasm
	>=dev-util/ninja-1.7.2
	>=sys-devel/bison-2.4.3
	sys-devel/flex
	virtual/pkgconfig
	media-libs/libexif
	dev-libs/nss
	sys-apps/pciutils
	sys-libs/ncurses:5/5[einfo]
	>=sys-devel/clang-5.0.0
	dev-vcs/git
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/chromium-${PV}"

pre_build_checks(){
	CHECKREQS_MEMORY="3G"
	CHECKREQS_DISK_BUILD="5G"
	eshopts_push -s extglob
	is-flagq '-g?(gdb)?([1-9])' && CHECKREQS_DISK_BUILD="25G"
	eshopts_pop
	check-reqs_pkg_setup
}

pkg_pretend(){
	pre_build_checks
}

pkg_setup(){
	pre_build_checks
	chromium_suid_sandbox_check_kernel_config
}

PATCHES=(
	"${FILESDIR}/chromium-compiler-r4.patch"
	"${FILESDIR}/chromium-widevine-r2.patch"
	"${FILESDIR}/chromium-webrtc-r0.patch"
	"${FILESDIR}/chromium-memcpy-r0.patch"
	"${FILESDIR}/chromium-math.h-r0.patch"
	"${FILESDIR}/chromium-stdint.patch"
	"${FILESDIR}/chromium-ffmpeg-ebp-r1.patch"
)

src_prepare(){
	python_setup
	sed -i -e 's/fuse-ld=lld/fuse-ld=bfd/' 'third_party/ffmpeg/chromium/scripts/build_ffmpeg.py'
	default
	"${EPYTHON}" tools/clang/scripts/update.py --without-android || die
	cp -a "${EPREFIX}"/usr/$(get_libdir)/libncursesw.so.5 'third_party/llvm-build/Release+Asserts/lib/libncursesw.so.5.9'
	cp -a "${EPREFIX}"/usr/$(get_libdir)/libtinfo.so.5 'third_party/llvm-build/Release+Asserts/lib/'
}

src_configure(){
	python_setup
	local myconf_gn=""
	tc-export AR CC CXX NM

	if ! tc-is-clang; then
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		strip-unsupported-flags
	fi

	if tc-is-clang; then
		myconf_gn+=" is_clang=true clang_use_chrome_plugins=true"
	else
		myconf_gn+=" is_clang=false"
	fi

	myconf_gn+=" ffmpeg_branding=\"ChromeOS\" proprietary_codecs=true enable_hevc_demuxing=true use_gnome_keyring=false use_sysroot=false use_gold=false use_allocator=\"none\" linux_use_bundled_binutils=false fatal_linker_warnings=false treat_warnings_as_errors=false enable_nacl=false enable_nacl_nonsfi=false is_component_build=true is_debug=false symbol_level=0 use_custom_libcxx=false use_lld=false use_jumbo_build=false target_cpu=\"x64\""

	replace-flags "-Os" "-O2"
	strip-flags
	filter-flags -mno-mmx -mno-sse2 -mno-ssse3 -mno-sse4.1 -mno-avx -mno-avx2

	export TMPDIR="${WORKDIR}/temp"
	mkdir -p -m 755 "${TMPDIR}" || die

	addpredict /dev/dri

	einfo "Configuring bundled ffmpeg..."
	pushd third_party/ffmpeg > /dev/null || die
	chromium/scripts/build_ffmpeg.py linux x64 \
		--branding "Chrome" -- || die
	chromium/scripts/copy_config.sh || die
	chromium/scripts/generate_gn.py || die
	popd > /dev/null || die

	einfo "Configuring Opera ffmpeg plugins..."
	set -- gn gen --args="${myconf_gn} ${EXTRA_GN}" out/Release
	echo "$@"
	"$@" || die
}

src_compile(){
	python_setup
	eninja -C out/Release -v media/ffmpeg
}

src_install(){
	insinto "/usr/$(get_libdir)/opera/lib_extra"
	doins out/Release/libffmpeg.so
}

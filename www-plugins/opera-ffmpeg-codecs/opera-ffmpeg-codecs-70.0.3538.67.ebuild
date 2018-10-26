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
	x11-libs/gtk+:3
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
	"${FILESDIR}/chromium-FORTIFY_SOURCE-r2.patch"
)

src_prepare(){
	python_setup
	default
}

src_configure(){
	python_setup
	local myconf_gn=""
	myconf_gn+=" ffmpeg_branding=\"ChromeOS\" proprietary_codecs=true enable_hevc_demuxing=true "
	myconf_gn+="use_gnome_keyring=false use_sysroot=false use_gold=false use_allocator=\"none\" "
	myconf_gn+="linux_use_bundled_binutils=false fatal_linker_warnings=false treat_warnings_as_errors=false "
	myconf_gn+="enable_nacl=false enable_nacl_nonsfi=false is_clang=false clang_use_chrome_plugins=false "
	myconf_gn+="is_component_build=true is_debug=false symbol_level=0 use_custom_libcxx=false "
	myconf_gn+="use_lld=false use_jumbo_build=false"

	einfo "Configuring Opera ffmpeg plugins..."
	set -- gn gen out/Release -v --args="${myconf_gn}"
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

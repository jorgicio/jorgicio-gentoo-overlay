# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit eutils check-reqs python-any-r1 ninja-utils

DESCRIPTION="Additional support for proprietary codecs for Opera"
HOMEPAGE="https://ffmpeg.org"
SRC_URI="https://commondatastorage.googleapis.com/chromium-browser-official/chromium-${PV}.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/ffmpeg"
RDEPEND="${DEPEND}"

S="${WORKDIR}/chromium-${PV}"

src_prepare(){
#	find . -name "*.py" -exec sed -r 's|/usr/bin/python$|&2|g' -i {} +
#	find . -name "*.py" -exec sed -r 's|/usr/bin/env python$|&2|g' -i {} +
#	[[ -d "${WORKDIR}/python2-path" ]] && rm -rf "${WORKDIR}/python2-path"
#	ln -s /usr/bin/python2 "${WORKDIR}/python2-path/python"
	touch chrome/test/data/webui/i18n_process_css_test.html
	PATCHES=(
		"${FILESDIR}/chromium-last-commit-position-r1.patch"
		"${FILESDIR}/chromium-FORTIFY_SOURCE-r1.patch"
		"${FILESDIR}/chromium-gn-bootstrap-r8.patch"
	)
	#epatch "${PATCHES[@]}"
	default
}

#pkg_setup(){
#	export PATH="${WORKDIR}/python2-path:$PATH"
#}

pre_build_checks(){
	CHECKREQS_MEMORY="3G"
	CHECKREQS_DISK_BUILD="5G"
	check-reqs_pkg_setup
}

pkg_pretend(){
	pre_build_checks
}

pkg_setup(){
	pre_build_checks
	python-any-r1_pkg_setup
}

src_configure(){
	local args="ffmpeg_branding=\"ChromeOS\" proprietary_codecs=true enable_hevc_demuxing=true use_gconf=false use_gio=false use_gnome_keyring=false use_kerberos=false use_cups=false use_sysroot=false use_gold=false linux_use_bundled_binutils=false fatal_linker_warnings=false treat_warnings_as_errors=false is_clang=false is_component_build=true is_debug=false symbol_level=0"
	python2 tools/gn/bootstrap/bootstrap.py -v --gn-gen-args "$args"
	out/Release/gn gen out/Release -v --args="$args" --script-executable=/usr/bin/python2
}

src_compile(){
	eninja -C out/Release -v media/ffmpeg || die
}

src_install(){
	insinto "${EPREFIX}/usr/lib/opera/lib_extra"
	doins out/Release/libffmpeg.so
}

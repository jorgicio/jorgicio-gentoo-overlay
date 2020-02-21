# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit linux-info git-r3 cmake-utils

CMAKE_MIN_VERSION="2.8.11"

DESCRIPTION="Small set of tools to control UKSM"
HOMEPAGE="https://github.com/kernelOfTruth/uksmtools"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="kernel_linux"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_pretend(){
	if use kernel_linux && kernel_is lt 2 6 32; then
		eerror "This version of UKSM tools requires a host kernel of 2.6.32 oh higher"
	elif use kernel_linux; then
		if ! linux_config_exists; then
			eerror "Unable to check your kernel for UKSM support"
		else
			CONFIG_CHECK="~UKSM"
			ERROR_UKSM="You must enable KSM support and set UKSM as your default page merging algorithm"
			check_extra_config
		fi
	fi
}

src_prepare(){
	# Install binaries in /usr/sbin instead of /usr/bin
	sed -i 's/bin/sbin/g;' CMakeLists.txt
	cmake-utils_src_prepare
}

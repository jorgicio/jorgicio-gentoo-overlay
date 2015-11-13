# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit linux-info git-r3 cmake-utils

CMAKE_MIN_VERSION="2.8.11"

DESCRIPTION="Small set of tools to control UKSM"
HOMEPAGE="https://github.com/pfactum/uksmtools"
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="9f59a3a0b494b758aa91d7d8fa04e21b5e6463c0"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
}

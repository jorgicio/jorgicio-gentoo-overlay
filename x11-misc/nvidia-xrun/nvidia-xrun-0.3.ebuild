# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Script to run dedicated X server with discrete nvidia graphics"
HOMEPAGE="https://github.com/Witko/nvidia-xrun"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="libglvnd"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	media-libs/mesa
	sys-power/bbswitch
	x11-apps/xinit
	x11-base/xorg-server[xorg,libglvnd?]
	x11-drivers/nvidia-drivers[X,driver,libglvnd?]
	x11-libs/libXrandr"

src_prepare() {
	if use libglvnd ; then
		sed -in -e "/\/nvidia\/xorg/d" \
			-e "s/\/nvidia/\/extensions\/nvidia/g" nvidia-xorg.conf
	else
		sed -in -e "/\/nvidia\/xorg/d" \
			-e "s/\/nvidia/\/opengl\/nvidia/g" nvidia-xorg.conf
		sed -in -e "s/\/nvidia\//\/opengl\/nvidia\/lib\//g" nvidia-xinitrc
	fi
	sed -in -e "s#/lib/#/lib64/#" nvidia-xorg.conf
	default
}

src_install() {
	dobin nvidia-xrun
	insinto /etc/X11
	doins nvidia-xorg.conf
	insinto /etc/X11/xinit
	doins nvidia-xinitrc
	dodir /etc/X11/xinit/nvidia-xinitrc.d
	dodir /etc/X11/nvidia-xorg.conf.d
}

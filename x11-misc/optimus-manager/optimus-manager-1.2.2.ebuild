# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1 systemd

DESCRIPTION="Management utility to handle GPU switching for Optimus laptops"
HOMEPAGE="https://github.com/Askannz/optimus-manager"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="gdm lightdm sddm systemd"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	x11-apps/xrandr
	x11-apps/mesa-progs
"
RDEPEND="
	${DEPEND}
	gdm? ( gnome-base/gdm )
	lightdm? ( x11-misc/lightdm )
	sddm? ( x11-misc/sddm )
	systemd? ( sys-apps/systemd )"
BDEPEND="${PYTHON_DEPS}"

src_install() {
	if use systemd; then
		systemd_dounit systemd/${PN}.service
		insinto /usr/$(get_libdir)/systemd/logind.conf.d
		doins systemd/logind/10-${PN}.conf
	fi
	insinto /lib/modprobe.d
	doins modules/${PN}.conf
	insinto /var/lib/${PN}
	doins var/*
	dobin scripts/*
	insinto /etc/${PN}
	doins config/*
	if use sddm; then
		insinto /etc/sddm.conf.d
		doins login_managers/sddm/20-${PN}.conf
	fi
	if use lightdm; then
		insinto /etc/lightdm.conf.d
		doins login_managers/lightdm/20-${PN}.conf
	fi
	insinto /usr/share
	doins ${PN}.conf
	newinitd ${FILESDIR}/${PN}.sh ${PN}
	distutils-r1_src_install
}

pkg_postinst() {
	echo
	elog "Default configuration can be found and /usr/share/${PN}.conf. Please do not edit it."
	elog "Use /etc/${PN}/${PN}.conf instead (if doesn't exist, create it)."
	elog "Also you can add options in /etc/${PN}/xorg-intel.conf and /etc/${PN}/xorg-nvidia.conf"
	elog "If you're using KDE Plasma or LXQt, you may require the optimus-manager-qt package."
	elog "If you're using Gnome, you can install the optimus-manager-argos Gnome Shell extension."
	ewarn "Only works with Xorg. Wayland is not supported yet."
	if use !sddm && use !gdm && use !lightdm; then
		elog "As you are not using support for SDDM, GDM and/or LightDM, you can set it manually."
		elog "More info can be found at:"
		elog "https://github.com/Askannz/optimus-manager/wiki/FAQ,-common-issues,-troubleshooting#my-display-manager-is-not-sddm-lightdm-nor-sddm"
	fi
	ewarn "If you have installed bumblebee package, you need to disable the bumblebee daemon since both packages are trying to"
	ewarn "control the GPU power switching."
	echo
}

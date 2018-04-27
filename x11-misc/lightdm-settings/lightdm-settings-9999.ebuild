# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="LightDM settings app to use it with the slick greeter"
HOMEPAGE="https://github.com/linuxmint/lightdm-settings"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	sys-devel/gettext
	dev-util/desktop-file-utils
"
RDEPEND="${DEPEND}
	dev-python/setproctitle
	dev-python/pygobject
	sys-auth/polkit
	dev-python/xapp
	x11-themes/hicolor-icon-theme
	sys-apps/lsb-release
	x11-misc/lightdm-slick-greeter
"

src_compile(){
	emake
}

src_install(){
	insinto /usr/$(get_libdir)
	doins -r usr/lib/*
	dobin usr/bin/${PN}
	insinto /usr
	doins -r usr/share
	fperms +x /usr/$(get_libdir)/${PN}/${PN}
}

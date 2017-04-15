# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="LightDM greeter that uses WebKit2 for theming via HTML/JavaScript"
HOMEPAGE="http://antergos.github.io/web-greeter https://github.com/Antergos/web-greeter"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Antergos/web-greeter"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/Antergos/web-greeter/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	 x11-misc/lightdm
	 net-libs/webkit-gtk:4[X]
	 dev-util/meson
	 sys-devel/gettext
	 dev-libs/dbus-glib
	 || ( x11-themes/gnome-backgrounds x11-themes/mate-backgrounds )
	 sys-apps/accountsservice
	 dev-libs/gobject-introspection
"
RDEPEND="${DEPEND}
	!x11-misc/lightdm-webkit-greeter
"

src_compile(){
	cd "${S}/build"
	meson --prefix=/usr --libdir=lib ..
	ninja
}

src_install(){
	cd "${S}/build"
	DESTDIR="${D}" ninja install
 }

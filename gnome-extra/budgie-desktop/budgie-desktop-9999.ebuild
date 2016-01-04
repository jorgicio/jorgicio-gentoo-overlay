# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
VALA_MIN_API_VERSION="0.28"
PYTHON_COMPAT=( python2_{6,7} )

inherit eutils autotools vala python-r1 git-r3

DESCRIPTION="Lightweight GNOME 3-based Desktop Environment used by Solus Project"
HOMEPAGE="http://solus-project.com"
EGIT_REPO_URI="https://github.com/solus-project/budgie-desktop"
SRC_URI=""

LICENSE="LGPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+introspection systemd"

DEPEND="
	${PYTHON_DEPS}
	$(vala_depend)
	introspection? ( >=dev-libs/gobject-introspection-1.44.0[${PYTHON_USEDEP}] )
"
RDEPEND="
	${DEPEND}
	>=x11-libs/libwnck-3.14.0:3
	>=gnome-base/gnome-menus-3.10.1
	gnome-base/gnome-settings-daemon
	>=dev-libs/libpeas-1.3.0
	>=x11-wm/mutter-3.18
	dev-util/desktop-file-utils
	dev-libs/libgee[introspection?]
	x11-themes/gnome-themes-standard
	>=x11-libs/gtk+-3.16:3
	media-sound/pulseaudio[X]
	systemd? ( 
		sys-apps/systemd
		sys-power/upower[introspection?] 
	)
	!systemd? ( sys-power/upower-pm-utils[introspection?] )
	dev-util/intltool
	>=gnome-base/gnome-session-3.18.0[systemd?]
	>=x11-terms/gnome-terminal-3.18.0
	gnome-base/gnome-control-center
	gnome-base/nautilus[introspection?]
	>=gnome-base/gnome-desktop-3.18.0:3
	>=sys-auth/polkit-0.105[systemd?]
"

src_prepare(){
	vala_src_prepare
	intltoolize
	eautoreconf
	export VALAC="$(type -p valac-$(vala_best_api_version))"
}

src_configure(){
	econf \
		$(use_enable introspection)
}

src_compile(){
	emake DESTDIR="${D}" || die
}

src_install(){
	emake DESTDIR="${D}" install || die
}

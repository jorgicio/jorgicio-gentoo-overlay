# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit bash-completion-r1 gnome2

DESCRIPTION="Clipboard management system"
HOMEPAGE="http://github.com/Keruspe/GPaste"
SRC_URI="http://www.imagination-land.org/files/gpaste//${P}.tar.xz"
RESTRICT="nomirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="applet bash-completion +gnome-shell +vala zsh-completion"

DEPEND=">=dev-libs/glib-2.30:2
	>=sys-devel/gettext-0.17
	>=dev-util/intltool-0.40
	>=x11-libs/gtk+-3.0.0:3
	dev-libs/libxml2
	x11-libs/libxcb
	sys-apps/dbus
	>=dev-libs/gobject-introspection-1.30.0
	>=dev-lang/vala-0.22.0:0.22[vapigen]"
RDEPEND="${DEPEND}
	bash-completion? ( app-shells/bash )
	gnome-shell? ( >gnome-base/gnome-shell-3.3.2 )
	zsh-completion? ( app-shells/zsh app-shells/zsh-completion )"

G2CONF="
	VALAC=$(type -p valac-0.22)
	VAPIGEN=$(type -p vapigen-0.22)
	--disable-schemas-compile
	$(use_enable applet)
	$(use_enable gnome-shell gnome-shell-extension)
	$(use_enable vala)"


REQUIRED_USE="|| ( gnome-shell applet )"

src_install() {
	use bash-completion && dobashcomp data/completions/gpaste
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins data/completions/_gpaste
	fi
	gnome2_src_install
	find ${D} -name '*.la' -exec rm -f {} +
}

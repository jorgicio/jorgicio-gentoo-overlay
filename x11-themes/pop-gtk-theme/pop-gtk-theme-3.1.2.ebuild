# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="System76 Pop GTK+ Theme, based in adapta-gtk-theme"
HOMEPAGE="http://github.com/pop-os/gtk-theme"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
	S="${WORKDIR}/${PN//pop-}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	>=x11-libs/gtk+-2.24.30:2
	>=x11-libs/gtk+-3.18.9:3
	>=x11-libs/gdk-pixbuf-2.24.30
	>=x11-themes/gtk-engines-murrine-0.98.1
	>=dev-libs/glib-2.48
	>=gnome-base/librsvg-2.40.13
	>=dev-libs/libsass-3.3.6
	dev-libs/libxml2
	>=dev-lang/sassc-3.3.2
	media-gfx/optipng
"

RDEPEND="${DEPEND}"

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-core-apps/gnome-core-apps-3.6.2.ebuild,v 1.7 2013/02/02 22:34:08 ago Exp $

EAPI="5"

DESCRIPTION="Sub-meta package for the core applications integrated with GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="+bluetooth +cdr cups +networkmanager"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# Note to developers:
# This is a wrapper for the core apps tightly integrated with GNOME 3
# gtk-engines:2 is still around because it's needed for gtk2 apps
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}[cups?]

	>=gnome-base/gnome-session-${PV}
	>=gnome-base/gnome-menus-3.6.1:3
	>=gnome-base/gnome-settings-daemon-3.6.3[cups?]
	>=gnome-base/gnome-control-center-3.6.3[cups?]

	>=app-crypt/gcr-${PV}
	>=gnome-base/nautilus-3.6.3
	>=gnome-base/gnome-keyring-${PV}
	>=gnome-base/libgnome-keyring-3.6
	>=gnome-extra/evolution-data-server-${PV}
	>=gnome-extra/gnome-power-manager-3.6
	>=gnome-extra/gnome-screensaver-3.6.1

	>=app-crypt/seahorse-3.6.3
	>=app-editors/gedit-${PV}
	>=app-text/evince-3.6.1
	>=gnome-extra/gnome-contacts-${PV}
	>=media-gfx/eog-${PV}
	>=media-video/totem-3.6.3
	>=net-im/empathy-${PV}
	>=x11-terms/gnome-terminal-3.6.1

	>=gnome-extra/gnome-user-docs-${PV}
	>=gnome-extra/yelp-${PV}

	>=x11-themes/gtk-engines-2.20.2:2
	>=x11-themes/gnome-icon-theme-${PV}
	>=x11-themes/gnome-icon-theme-symbolic-${PV}
	>=x11-themes/gnome-themes-standard-${PV}

	bluetooth? ( >=net-wireless/gnome-bluetooth-3.6 )
	cdr? ( >=app-cdr/brasero-3.6.1 )
	networkmanager? ( >=gnome-extra/nm-applet-0.9.6.4[bluetooth?] )
"
DEPEND=""

S="${WORKDIR}"

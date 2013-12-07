# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-extra-apps/gnome-extra-apps-3.6.2.ebuild,v 1.8 2013/02/02 22:34:48 ago Exp $

EAPI="5"

DESCRIPTION="Sub-meta package for the applications of GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="+shotwell +tracker"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# Note to developers:
# This is a wrapper for the extra apps integrated with GNOME 3
# New package
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}

	>=app-admin/gnome-system-log-3.6.1
	>=app-arch/file-roller-${PV}
	>=app-dicts/gnome-dictionary-3.6.0
	>=games-board/aisleriot-3.2.3.2
	>=gnome-extra/gcalctool-6.6.2
	>=gnome-extra/gconf-editor-3
	>=gnome-extra/gnome-games-3.6.1
	>=gnome-extra/gnome-search-tool-3.6
	>=gnome-extra/gnome-system-monitor-3.6.1
	>=gnome-extra/gnome-tweak-tool-3.6.1
	>=gnome-extra/gucharmap-3.6.1:2.90
	>=gnome-extra/sushi-3.6.1
	>=mail-client/evolution-${PV}
	>=media-gfx/gnome-font-viewer-3.6.1
	>=media-gfx/gnome-screenshot-3.6.1
	>=media-sound/sound-juicer-3.5.0
	>=media-video/cheese-${PV}
	>=net-analyzer/gnome-nettool-3.2
	>=net-misc/vinagre-${PV}
	>=net-misc/vino-${PV}
	>=sys-apps/baobab-${PV}
	>=www-client/epiphany-3.6.1

	shotwell? ( >=media-gfx/shotwell-0.12 )
	tracker? (
		>=app-misc/tracker-0.14.1
		>=gnome-extra/gnome-documents-3.6.2 )
"
# Note: bug-buddy is broken with GNOME 3
# Note: aisleriot-3.4 is masked for guile-2
DEPEND=""
S=${WORKDIR}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-extra-apps/gnome-extra-apps-3.8.0-r1.ebuild,v 1.5 2013/11/30 19:07:39 pacho Exp $

EAPI="5"

DESCRIPTION="Sub-meta package for the applications of GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="+games +shotwell +tracker +web"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# Note to developers:
# This is a wrapper for the extra apps integrated with GNOME 3
# New package
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}

	>=app-admin/gnome-system-log-${PV}
	>=app-arch/file-roller-${PV}
	>=app-dicts/gnome-dictionary-3.6.0
	>=gnome-extra/gconf-editor-3
	>=gnome-extra/gnome-calculator-${PV}
	>=gnome-extra/gnome-power-manager-${PV}
	>=gnome-extra/gnome-search-tool-3.6
	>=gnome-extra/gnome-system-monitor-${PV}
	>=gnome-extra/gnome-tweak-tool-3.7.4
	>=gnome-extra/gucharmap-${PV}:2.90
	>=gnome-extra/nautilus-sendto-${PV}
	>=gnome-extra/sushi-${PV}
	>=mail-client/evolution-${PV}
	>=media-gfx/gnome-font-viewer-${PV}
	>=media-gfx/gnome-screenshot-${PV}
	>=media-sound/sound-juicer-3.5.0
	>=media-video/cheese-${PV}
	>=net-analyzer/gnome-nettool-3.2
	>=net-misc/vinagre-${PV}
	>=net-misc/vino-${PV}
	>=sys-apps/baobab-${PV}
	web? ( >=www-client/epiphany-${PV} )

	games? (
		>=games-arcade/gnome-nibbles-${PV}
		>=games-arcade/gnome-robots-${PV}
		>=games-board/aisleriot-3.2.3.2
		>=games-board/four-in-a-row-${PV}
		>=games-board/gnome-chess-${PV}
		>=games-board/gnome-mahjongg-${PV}
		>=games-board/gnome-mines-${PV}
		>=games-board/iagno-${PV}
		>=games-board/tali-${PV}
		>=games-puzzle/five-or-more-${PV}
		>=games-puzzle/gnome-klotski-${PV}
		>=games-puzzle/gnome-sudoku-${PV}
		>=games-puzzle/gnome-tetravex-${PV}
		>=games-puzzle/lightsoff-${PV}
		>=games-puzzle/quadrapassel-${PV}
		>=games-puzzle/swell-foop-${PV} )
	shotwell? ( >=media-gfx/shotwell-0.14 )
	tracker? (
		>=app-misc/tracker-0.16
		>=gnome-extra/gnome-documents-${PV} )
"
# Note: bug-buddy is broken with GNOME 3
# Note: aisleriot-3.4 is masked for guile-2
DEPEND=""
S=${WORKDIR}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/redshift-plasmoid/redshift-plasmoid-0.6.2.ebuild,v 1.1 2014/01/08 06:34:46 mrueg Exp $

EAPI=5

KDE_LINGUAS="de fr it"
inherit kde4-base

DESCRIPTION="KDE4 plasmoid for redshift."
HOMEPAGE="http://kde-apps.org/content/show.php/Redshift+Plasmoid?content=148737 https://github.com/simgunz/redshift-plasmoid/"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/148737-${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="$(add_kdebase_dep plasma-workspace)"
RDEPEND="${DEPEND}
	x11-misc/redshift"

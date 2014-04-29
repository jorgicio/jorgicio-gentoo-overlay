# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="en es de"
inherit kde4-base

DESCRIPTION="KDE4 plasmoid for viewing capslocks and numlocks."
HOMEPAGE="http://kde-look.org/content/show.php/plasmoid-capslockinfo?content=156181"
SRC_URI="http://kde-look.org/CONTENT/content-files/156181-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="$(add_kdebase_dep plasma-workspace)"
RDEPEND="${DEPEND}"

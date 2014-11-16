# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Plasmoid for querying the RAE dictionary (Diccionario de la Real Academa Española) for the Spanish-language users"
HOMEPAGE="http://kde-look.org/content/show.php/raecas?content=159437"
SRC_URI="http://build.opensuse.org/source/home:javierllorente/plasmoid-raecas/raecas-0.1.tar.bz2?rev=75dc9095a456e4c5b780fd09a9e9fb44 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="$(add_kdebase_dep plasma-workspace)"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

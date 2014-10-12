# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Provides precompiled 32bit libraries for KDE's Oxygen interface."
HOMEPAGE="http://forums.gentoo.org/viewtopic-t-991592-start-0.html"
SRC_URI="https://owncloud.tu-berlin.de/public.php?service=files&t=8e48013015b9d6dcb4086ba0f02a21b5&download -> ${P}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-qt/qtcore:4
		|| (
			=kde-base/kdebase-meta-4.13.3
			=kde-base/kde-meta-4.13.3
			=kde-base/kdebase-startkde-4.13.3
			)"
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr
	doins -r usr/lib32
}

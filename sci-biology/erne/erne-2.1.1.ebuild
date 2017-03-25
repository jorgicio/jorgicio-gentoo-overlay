# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Extended Randomized Numerical alignEr for accurate alignment of NGS reads"
HOMEPAGE="http://erne.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64 ~amd64-linux ~x86-linux ~x86-macos ~x64-macos ~x86-fbsd ~amd64-fbsd ~sparc-solaris ~sparc64-solaris ~x86-solaris ~hppa"
IUSE="debug mpi mpich"

REQUIRED_USE="mpi? ( !mpich )"

DEPEND=">=dev-libs/boost-1.40
	mpi? ( sys-cluster/openmpi[cxx] )
	mpich? ( || ( sys-cluster/mpich[cxx]  sys-cluster/mpich2[cxx] ) )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-source"

src_configure(){
	econf \
		$(use_enable debug maintainer-mode) \
		$(use_enable mpi openmpi) \
		$(use_enable mpich) \
		$(usex hppa "CC=\"cc -Ae -D_XOPEN_SOURCE=500\"" "")
}

src_install(){
	emake DESTDIR="${D}" install
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit autotools desktop

RNAME="Potassium"
DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
SRC_URI="${HOMEPAGE}/download/${P}-${RNAME}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +ocamlopt"
RESTRICT="strip"

RDEPEND=">=dev-lang/ocaml-4.02[ocamlopt?]
		dev-ml/camlp4[ocamlopt?]
		>=dev-ml/ocamlgraph-1.8.5[ocamlopt?]
		dev-ml/zarith[ocamlopt?]
		gtk? ( >=dev-ml/lablgtk-2.14[sourceview,gnomecanvas,ocamlopt?] )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}-${RNAME}"

src_prepare(){
	touch config_file

	eautoreconf
	default_src_prepare
}

src_configure(){
	econf\
		$(use_enable gtk gui)
}

src_compile(){
	# dependencies can not be processed in parallel,
	# this is the intended behavior.
	emake -j1 depend || die "emake depend failed"
	emake all DESTDIR="/" || die "emake failed"
}

src_install(){
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc Changelog doc/README

	if use gtk;then
		doicon "${FILESDIR}"/${PN}.png
		make_desktop_entry "frama-c-gui" "Frama-C GUI" "frama-c" "Development"
	fi
}

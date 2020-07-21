# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools desktop

RNAME="Scandium"
DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="https://frama-c.com"
SRC_URI="${HOMEPAGE}/download/${P}-${RNAME}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +ocamlopt"
RESTRICT="strip"

RDEPEND=">=dev-lang/ocaml-4.02[ocamlopt?]
		dev-ml/camlp4[ocamlopt?]
		>=dev-ml/ocamlgraph-1.8.5[gtk?,ocamlopt?]
		dev-ml/yojson
		dev-ml/zarith[ocamlopt?]
			gtk? ( >=dev-ml/lablgtk-2.14[sourceview,gnomecanvas,ocamlopt?] )"
DEPEND="${RDEPEND}
	dev-ml/findlib
	dev-ml/lablgl:=[ocamlopt?]
	media-gfx/graphviz
	sci-mathematics/coq"

S="${WORKDIR}/${P}-${RNAME}"

src_prepare(){
	touch config_file
	default
	eautoreconf
}

src_configure(){
	econf \
		$(use_enable gtk gui)
}

src_compile(){
	emake depend
	emake all
}

src_install(){
	emake install DESTDIR="${ED}"
	dodoc Changelog doc/README

	if use gtk; then
		doicon "${FILESDIR}"/${PN}.png
		make_desktop_entry "frama-c-gui" "Frama-C GUI" "frama-c" "Development"
	fi
}

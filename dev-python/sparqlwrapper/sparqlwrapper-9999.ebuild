# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
inherit distutils-r1

DESCRIPTION="SPARQL Endpoint interface to Python"
HOMEPAGE="http://rdflib.github.io/sparqlwrapper"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RDFLib/sparqlwrapper"
	SRC_URI=""
	KEYWORDS=""
else
	MY_PN="SPARQLWrapper"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="W3C"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
	>=dev-python/rdflib-4.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

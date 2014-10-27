# Distributed under the terms of the GNU General Public License v2
# Disclaimer: This ebuild is only for Funtoo users. Gentoo (and other Gentoo-based flavoured) users must use their own pillow/PIL ebuild.

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3,3_4} )
PYTHON_RESTRICTED_ABIS="*-jython"

inherit distutils-r1 eutils

MY_PN="Pillow"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Headers for the Python Imaging Library"
HOMEPAGE="https://github.com/python-pillow/Pillow https://pypi.python.org/pypi/Pillow"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="HPND"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=">=dev-python/imaging-${PV}"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

python_install(){
	python_doheader libImaging/*.h || die
}

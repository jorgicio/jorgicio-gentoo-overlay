# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="An indicator for working with PushBullet"
HOMEPAGE="http://launchpad.net/pushbullet-indicator"
SRC_URI="http://launchpad.net/~atareao/+archive/ubuntu/${PN//-indicator}/+files/${PN}_${PV}-0extras16.04.0.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-libs/libappindicator:3[introspection]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ws4py[${PYTHON_USEDEP}]
	dev-python/pushbullet-commons
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	dev-python/polib[${PYTHON_USEDEP}]
	dev-python/pywebkitgtk
"
RDEPEND="${DEPEND}
	x11-misc/shared-mime-info"

S="${WORKDIR}/${PN}"

src_prepare(){
	sed -i "s|os.path.join(ROOTDIR, 'locale-langpack')|'/usr/share/locale/'|g" ./src/comun.py || die
	eapply_user
}

PYTHON2_BIN="$(which python2)"

distutils-r1_python_compile(){
	${PYTHON2_BIN} setup.py build || die "No binary python2 or some missing dependency found"
}

distutils-r1_python_install(){
	${PYTHON2_BIN} setup.py install --root="${D}" --optimize=1 || die "No binary python2 or some missing dependency found"
	insinto /usr/share/licenses/${PN}/LICENSE
	doins LICENSE
	insinto /usr/share/locale
	doins -r ./build/locale-langpack
}

pkg_postinst(){
	rm -rf /opt/extras.ubuntu.com/${PN}/share/locale-langpack
}

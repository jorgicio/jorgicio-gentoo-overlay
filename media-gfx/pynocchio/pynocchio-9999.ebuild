# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit desktop distutils-r1 xdg

DESCRIPTION="Qt-based image viewer specialized in manga/comic reading"
HOMEPAGE="https://mstuttgart.github.io/pynocchio"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mstuttgart/pynocchio"
else
	SRC_URI="https://github.com/mstuttgart/pynocchio/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-python/coveralls[${PYTHON_USEDEP}]
	dev-python/rarfile[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-python/pyqt-distutils[${PYTHON_USEDEP}]
	dev-python/sip[${PYTHON_USEDEP}]
	dev-qt/linguist:5
	dev-python/PyQt5[gui,multimedia,sql,${PYTHON_USEDEP}]
	app-arch/unrar
	dev-qt/qtsql:5[sqlite]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-qt/linguist-tools:5"

src_prepare(){
	mv ./${PN}-client.py ./scripts/${PN} || die
	sed -i "s#pynocchio-client.py#scripts/pynocchio#" setup.py || die
	default
}

src_install() {
	distutils-r1_src_install
	domenu linux/applications/${PN}.desktop
	doicon linux/pixmaps/${PN}.png
	for size in 16 32 48 128 256; do
		doicon -s ${size} -t hicolor linux/hicolor/${size}x${size}/apps/${PN}.png
	done

}

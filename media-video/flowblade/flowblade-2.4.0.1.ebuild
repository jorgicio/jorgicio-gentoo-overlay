# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit desktop python-any-r1 xdg

DESCRIPTION="A multitrack non-linear video editor"
HOMEPAGE="https://github.com/jliljebl/flowblade"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/${PN}-trunk"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}-fix_release.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${P}-fix_release/${PN}-trunk"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	>=x11-libs/gtk+-3.0:3
	$(python_gen_any_dep 'dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]' )
	>=media-libs/mlt-6.18.0[python,ffmpeg,gtk]
	$(python_gen_any_dep 'dev-python/dbus-python[${PYTHON_USEDEP}]' )
	media-plugins/frei0r-plugins
	media-plugins/swh-plugins
	$(python_gen_any_dep 'dev-python/pycairo[${PYTHON_USEDEP}]')
	$(python_gen_any_dep 'dev-python/numpy[${PYTHON_USEDEP}]' )
	$(python_gen_any_dep 'dev-python/pillow[${PYTHON_USEDEP}]' )
	gnome-base/librsvg:2=
	media-gfx/gmic[ffmpeg,X]
	dev-libs/glib:2[dbus]
	x11-libs/gdk-pixbuf:2[X]
	media-video/ffmpeg
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	eapply -p2 "${FILESDIR}/${PN}-${PV:0:3}-install-dir-fix.patch"
	default
}

src_install(){
	local filename="io.github.jliljebl.${PN^}"
	python_fix_shebang ${PN}
	dobin ${PN}
	insinto /usr/share/${PN}
	doins -r Flowblade/*
	doman installdata/${PN}.1
	dodoc README
	doicon -s 128 installdata/${filename}.png
	domenu installdata/${filename}.desktop
	insinto /usr/share/mime/packages
	doins installdata/${filename}.xml
}

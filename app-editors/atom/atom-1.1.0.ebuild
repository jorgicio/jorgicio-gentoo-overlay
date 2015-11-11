# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit flag-o-matic python-any-r1 eutils

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io"
SRC_URI="https://github.com/atom/atom/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	|| ( net-libs/nodejs[npm] net-libs/iojs[npm] )
	media-fonts/inconsolata
	gnome-base/gconf
	x11-libs/gtk+:2
	gnome-base/libgnome-keyring
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	media-libs/alsa-lib
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python-any-r1_pkg_setup

	npm config set python $PYTHON
}

src_prepare(){
	epatch "${FILESDIR}/${PN}-python-${PV}.patch"
#	epatch "${FILESDIR}/${PN}-package.patch"
	sed -i -e "/exception-reporting/d" \
      -e "/metrics/d" package.json
	sed -e "s/<%= description %>/$pkgdesc/" \
    -e "s|<%= executable %>|/usr/bin/atom|"\
    -e "s|<%= iconName %>|atom|"\
    resources/linux/atom.desktop.in > resources/linux/Atom.desktop
    # Fix atom location guessing
	sed -i -e 's/ATOM_PATH="$USR_DIRECTORY\/share\/atom/ATOM_PATH="$USR_DIRECTORY\/../g' \
		./atom.sh \
		|| die "Fail fixing atom-shell directory"
	# Make bootstrap process more verbose
	sed -i -e 's@node script/bootstrap@node script/bootstrap --no-quiet@g' \
		./script/build \
		|| die "Fail fixing verbosity of script/build"
}

src_compile(){
	./script/build --verbose --build-dir "${T}" || die "Failed to compile"
	"${T}/Atom/resources/app/apm/bin/apm" rebuild || die "Failed to rebuild native module"
	echo "python = $PYTHON" >> "${T}/Atom/resources/app/apm/.apmrc"
}

src_install(){
	insinto ${EPREFIX}/usr/share/${PN}
	doins -r ${T}/Atom/*
	insinto ${EPREFIX}/usr/share/applications
	newins resources/linux/Atom.desktop atom.desktop
	insinto ${EPREFIX}/usr/share/pixmaps
    mv resources/app-icons/stable/png/128.png resources/app-icons/stable/png/atom.png
	doins resources/app-icons/stable/png/atom.png
	insinto ${EPREFIX}/usr/share/licenses/${PN}
	doins LICENSE.md
	# Fixes permissions
	fperms +x ${EPREFIX}/usr/share/${PN}/${PN}
	fperms +x ${EPREFIX}/usr/share/${PN}/libffmpegsumo.so
	fperms +x ${EPREFIX}/usr/share/${PN}/libgcrypt.so.11
	fperms +x ${EPREFIX}/usr/share/${PN}/libnotify.so.4
	fperms +x ${EPREFIX}/usr/share/${PN}/resources/app/atom.sh
	fperms +x ${EPREFIX}/usr/share/${PN}/resources/app/apm/bin/apm
	fperms +x ${EPREFIX}/usr/share/${PN}/resources/app/apm/bin/node
	fperms +x ${EPREFIX}/usr/share/${PN}/resources/app/apm/node_modules/npm/bin/node-gyp-bin/node-gyp
	# Symlinking to /usr/bin
	dosym ${EPREFIX}/usr/share/${PN}/resources/app/atom.sh /usr/bin/atom
	dosym ${EPREFIX}/usr/share/${PN}/resources/app/apm/bin/apm /usr/bin/apm
}

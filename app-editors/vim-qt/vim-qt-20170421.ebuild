# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIM_VERSION="8.1"
PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )
PYTHON_REQ_USE="threads(+)"
USE_RUBY="ruby23 ruby24 ruby25"

inherit autotools desktop flag-o-matic python-single-r1 prefix xdg-utils ruby-single vim-doc

DESCRIPTION="An experimental Qt5 gui for Vim."
HOMEPAGE="https://github.com/equalsraf/vim-qt"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/package-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
	S="${WORKDIR}/${PN}-package-${PV}"
fi

LICENSE="vim"
SLOT="0"
IUSE="acl aqua cscope debug gpm lua luajit netbeans nls racket perl python ruby selinux session tcl"

REQUIRED_USE="
	luajit? ( lua )
	python? ( ${PYTHON_REQUIRED_USE} )
"

DEPEND="
	sys-apps/gawk
"

RDEPEND="
	${DEPEND}
	>=app-eselect/eselect-vi-1.1
	>=sys-libs/ncurses-5.2-r2:0=
	!aqua? (
		dev-qt/qtgui:5
		dev-qt/qtcore:5
	)
	acl? ( kernel_linux? ( sys-apps/acl ) )
	gpm? ( sys-libs/gpm )
	python? ( ${PYTHON_DEPS} )
	lua? (
		luajit? ( dev-lang/luajit:2= )
		!luajit? ( dev-lang/lua:0[deprecated] )
	)
	ruby? ( ${RUBY_DEPS} )
	perl? ( dev-lang/perl:= )
	racket? ( dev-scheme/racket )
	selinux? ( sys-libs/libselinux )
	session? ( x11-libs/libSM )
	tcl? ( dev-lang/tcl:= )
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXt
"

PDEPEND="~app-editors/vim-core-${VIM_VERSION}"

BDEPEND="
	dev-util/ctags
	sys-devel/autoconf
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

pkg_setup(){
	unset LANG LC_ALL
	export LC_COLLATE="C"
	use python && python-single-r1_pkg_setup
}

PATCHES=( "${FILESDIR}/${PN}-enable-python-command.patch" )

src_prepare(){
	default_src_prepare
	cd src
	eautoreconf
	sed -i -e "s#VIMMINOR = 0#VIMMINOR = 1#" Makefile
	sed -i -e "s#\#VIMRUNTIMEDIR#VIMRUNTIMEDIR#" Makefile
	cd -
	sed -i -e \
		'1s|.*|#!'"${EPREFIX}"'/usr/bin/awk -f|' \
				"${S}"/runtime/tools/mve.awk || die "mve.awk sed failed"
	cp runtime/gvim.desktop runtime/qvim.desktop || die
	sed -i -e "s#GVim#QVim#" runtime/qvim.desktop
	sed -i -e "s#gvim#qvim#" runtime/qvim.desktop
	echo '#define SYS_VIMRC_FILE "'${EPREFIX}'/etc/vim/vimrc"' \
		>> "${S}"/src/feature.h || die "echo failed"
}

src_configure(){
	filter-flags -funroll-all-loops
	replace-flags -O3 -O2
	use debug && append-flags "-DDEBUG"
	local myconf=(
		--prefix="${EPREFIX}/usr"
		--enable-fail-if-missing
		$(use_enable acl)
		$(use_enable cscope)
		--enable-multibyte
		$(use_enable netbeans)
		$(use_enable nls)
		$(use_enable lua luainterp)
		$(use_enable perl perlinterp)
		$(use_enable python pythoninterp)
		$(use_enable python python3interp)
		$(use_with python python-command $(type -P $(eselect python show --python2)))
		$(use_with python python3-command $(type -P $(eselect python show --python3)))
		$(use_enable racket mzschemeinterp)
		$(use_enable ruby rubyinterp)
		$(use_with ruby ruby-command $(type -P ruby))
		$(use_enable gpm)
		$(use_enable tcl tclinterp)
		$(use_enable selinux)
		$(use_enable session xsmp)
		--with-features=huge
	)

	if ! use cscope; then
		sed -i -e \
			'/# define FEAT_CSCOPE/d' src/feature.h || die "couldn't disable cscope"
	fi

	if use aqua; then
		einfo "Building qvim with the Carbon GUI"
		myconf+=( --enable-darwin
			--enable-gui=carbon
		) 
	else
		einfo "Building vim with the QT5 interface"
		myconf+=( --enable-gui=qt
			--with-qt-qmake=$(type -P qmake)
		)
	fi

	use prefix && myconf+=( --without-local-dir )

	export ac_cv_prog_STRIP="$(type -P true ) faking strip"

	if [[ ${CHOST} == *-interix* ]]; then
		export ac_cv_func_sigaction=no
	fi

	econf \
		--with-compiledby="Gentoo Portage Overlay from Jorgicio" \
		--with-modified-by=Gentoo-${PVR} \
		--with-vim-name=qvim \
		--with-ex-name=qex \
		--with-view-name=qview \
		--with-x \
		--with-global-runtime=/usr/share/vim/vim81 \
		${myconf[@]}
}

src_compile(){
	emake -j1 -C src auto/osdef.h objects
	emake
}


eselect_vi_update() {
	einfo "Calling eselect vi update..."
	eselect vi update --if-unset
	eend $?
}

src_install(){
	local vimfiles=/usr/share/vim/vim${VIM_VERSION/.}
	emake -C src DESTDIR="${D}" DATADIR="${EPREFIX}/usr/share" installvimbin
	emake -C src DESTDIR="${D}" DATADIR="${EPREFIX}/usr/share" installtutorbin
	emake -C src DESTDIR="${D}" DATADIR="${EPREFIX}/usr/share" installgtutorbin
	emake -C src DESTDIR="${D}" DATADIR="${EPREFIX}/usr/share" installlinks
	emake -C src DESTDIR="${D}" DATADIR="${EPREFIX}/usr/share" installmanlinks
	for s in 16 32 48; do
		newicon -s ${s}x${s} runtime/vim${s}x${s}.png qvim.png
	done
	newicon -s 64x64 src/qt/icons/${PN}.png qvim.png
	domenu runtime/qvim.desktop
	dodir /usr/share/man/man1
	echo ".so vim.1" > "${ED}"/usr/share/man/man1/qvim.1 || die "echo failed"
	echo ".so vim.1" > "${ED}"/usr/share/man/man1/qview.1 || die "echo failed"
	echo ".so vimdiff.1" > "${ED}"/usr/share/man/man1/qvimdiff.1 || die "echo failed"
	insinto /etc/vim
	doins "${FILESDIR}/qvimrc"
	eprefixify "${ED}"/etc/vim/qvimrc

}

pkg_postinst(){
	update_vim_helptags
	xdg_desktop_database_update
	eselect_vi_update
}

pkg_postrm(){
	update_vim_helptags
	xdg_desktop_database_update
	eselect_vi_update
}

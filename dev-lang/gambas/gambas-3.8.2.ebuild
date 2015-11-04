# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools eutils fdo-mime libtool multilib qt4-r2

DESCRIPTION="Gambas is a free development environment based on a Basic interpreter with object extensions"
HOMEPAGE="http://gambas.sourceforge.net/"

MY_PN="gambas3"
SLOT="0"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="amd64 x86"
IUSE="bzip2 cairo crypt curl dbus +desktop examples gmp gsl gtk httpd +imageio imageimlib \
	jit libxml media mysql mime ncurses net opengl postgres odbc openssl openal pcre pdf \
	+qt4 sdl sdlsound smtp sqlite +sqlite3 svg v4l xml zlib"

# libcrypt.so is part of glibc
COMMON_DEPEND="
	bzip2?	( >=app-arch/bzip2-1.0.5 )
	cairo?	( >=x11-libs/cairo-1.6 )
	curl?	( >=net-misc/curl-7.15.5-r1 )
	dbus?	( sys-apps/dbus )
	desktop?	(
		x11-libs/libXtst
		x11-misc/xdg-utils
		gnome-base/gnome-keyring
	)
	gmp?	( dev-libs/gmp )
	gsl?	( sci-libs/gsl )
	gtk?	(
		>=x11-libs/gtk+-2.16:2[cups]
		>=x11-libs/cairo-1.6
		svg? ( >=gnome-base/librsvg-2.16.1-r2 )
		>=x11-libs/gtkglext-1.0
	)
	imageio?	( x11-libs/gdk-pixbuf )
	imageimlib?	( media-libs/imlib2 )
	jit?	( >=sys-devel/llvm-3.1 )
	libxml?	( dev-libs/libxml2 )
	media?	(
		>=media-libs/gstreamer-1.0
		media-libs/gst-plugins-base
		media-plugins/gst-plugins-xvideo
		media-tv/v4l-utils
	)
	mysql?	(
		>=virtual/mysql-5.0
		>=sys-libs/zlib-1.2.3-r1
	)
	mime?	( >=dev-libs/gmime-2.6 )
	ncurses?	( sys-libs/ncurses )
	net?	( >=net-misc/curl-7.13 )
	odbc?	( dev-db/unixODBC )
	openal? ( media-libs/alure )
	opengl?	(
		>=media-libs/mesa-7.0.2
		|| ( x11-drivers/nvidia-drivers x11-drivers/ati-drivers x11-libs/libGlw )
		media-libs/glew
		media-libs/glu
	)
	openssl?	( dev-libs/openssl )
	pcre?	( >=dev-libs/libpcre-7.6-r1 )
	pdf?	( >=app-text/poppler-0.5 )
	postgres?	( >=dev-db/postgresql-base-8.2 )
	pcre?	( dev-libs/libpcre )
	qt4? (
		>=dev-qt/qtcore-4.5
		>=dev-qt/qtopengl-4.5
		>=dev-qt/qtwebkit-4.5
	)
	sdl?	(
		media-libs/sdl-ttf
		>=media-libs/sdl-mixer-1.2.7
		>=media-libs/mesa-7.0.2
		|| ( x11-drivers/nvidia-drivers x11-drivers/ati-drivers x11-libs/libGlw )
		media-libs/glew
	)
	sdlsound?	( media-libs/sdl-sound )
	smtp?	( >=dev-libs/glib-2.16.2 )
	sqlite?	( =dev-db/sqlite-2* )
	sqlite3?	( >=dev-db/sqlite-3.5.6 )
	svg?	( gnome-base/librsvg )
	v4l?	(
		media-tv/v4l-utils
		>=media-libs/libpng-1.2.26
		virtual/jpeg
	)
	xml?	(
		>=dev-libs/libxml2-2.6.31
		>=dev-libs/libxslt-1.1.22
	)
	zlib?	( >=sys-libs/zlib-1.2.3-r1 )
	x11-libs/libSM
	x11-libs/libXcursor
	virtual/libffi
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/xdgutils.patch
	elibtoolize
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable bzip2 bzlib2) \
		$(use_enable zlib) \
		$(use_enable mysql) \
		$(use_enable odbc) \
		$(use_enable postgres postgresql) \
		$(use_enable sqlite sqlite2) \
		$(use_enable sqlite3) \
		$(use_enable net) \
		$(use_enable curl) \
		$(use_enable smtp) \
		$(use_enable mime) \
		$(use_enable pcre) \
		$(use_enable sdl) \
		$(use_enable sdlsound) \
		$(use_enable libxml) \
		$(use_enable xml) \
		$(use_enable v4l) \
		$(use_enable crypt) \
		$(use_enable qt4) \
		$(use_enable gtk) \
		$(use_enable opengl) \
		$(use_enable desktop) \
		$(use_enable pdf) \
		$(use_enable cairo) \
		$(use_enable imageio) \
		$(use_enable imageimlib) \
		$(use_enable dbus) \
		$(use_enable gsl) \
		$(use_enable gmp) \
		$(use_enable ncurses) \
		$(use_enable media) \
		$(use_enable jit) \
		$(use_enable httpd) \
		$(use_enable openssl) \
		$(use_enable openal)
}

src_install() {
	DESTDIR="${D}" make install || die "emake install failed"

	dodoc AUTHORS README TODO
	use net && { newdoc gb.net/src/doc/README gb.net-README; }
	use net && { newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog; }
	use pcre && { newdoc gb.pcre/src/README gb.pcre-README; }
	use sqlite && { newdoc gb.db.sqlite2/README gb.db.squlite2-README; }
	use sqlite3 && { newdoc gb.db.sqlite3/README gb.db.sqlite3-README; }
	use jit && { newdoc gb.jit/README gb.jit-README; }
	use smtp && { newdoc gb.net.smtp/README gb.net.smtp-README; }

	if { use qt4 || use gtk; } ; then
		newicon -s 128 app/src/${MY_PN}/img/logo/logo.png gambas3.png
		doicon -s 64 -c mimetypes app/mime/*.png main/mime/*.png
		insinto /usr/share/applications
		doins app/desktop/gambas3.desktop
		insinto /usr/share/mime/application
		doins app/mime/*.xml main/mime/*.xml
	fi
}

my_fdo_update() {
	{ use qt4 || use gtk; } && fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postinst() {
	my_fdo_update
}

pkg_postrm() {
	my_fdo_update
}

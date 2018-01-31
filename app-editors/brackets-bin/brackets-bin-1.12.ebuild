# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker gnome2-utils xdg-utils

DESCRIPTION="A code editor for HTML, CSS and JavaScript"
HOMEPAGE="http://brackets.io/"

SRC_URI="
	amd64? ( https://github.com/adobe/brackets/releases/download/release-${PV}/Brackets.Release.${PV}.64-bit.deb
			mirror://debian/pool/main/p/pango1.0/libpangoft2-1.0-0_1.40.5-1_amd64.deb )
	x86?   ( https://github.com/adobe/brackets/releases/download/release-${PV}/Brackets.Release.${PV}.32-bit.deb
			mirror://debian/pool/main/p/pango1.0/libpangoft2-1.0-0_1.40.5-1_i386.deb )"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
LICENSE="MIT"
IUSE="live_preview"
SLOT="0"

QA_PRESTRIPPED="/opt/brackets/libpangoft2-1.0.so.0.4000.5"

DEPEND=""
RDEPEND="${DEPEND}
	!app-editors/brackets
	>=dev-libs/atk-1.12.4
	>=dev-libs/expat-1.95.8
	>=dev-libs/glib-2.18.0:2
	>=dev-libs/nspr-1.8.0.10
	>=dev-libs/nss-3.12.6
	>=dev-libs/openssl-1.0.2k:0
	>=gnome-base/gconf-2.31.1
	>=media-libs/alsa-lib-1.0.23
	>=media-libs/fontconfig-2.8.0
	>=media-libs/freetype-2.3.9
	>=net-print/cups-1.4.0
	>=sys-apps/dbus-1.2.14
	>=sys-devel/gcc-4.1.1
	>=virtual/libudev-198
	>=x11-libs/cairo-1.6.0
	>=x11-libs/gdk-pixbuf-2.22.0
	>=x11-libs/gtk+-2.24.0:2
	>=x11-libs/pango-1.22.0
	>=x11-libs/libX11-1.4.99.1
	>=x11-libs/libXcomposite-0.3-r1
	>=x11-libs/libXdamage-1.1
	>=x11-libs/libXrandr-1.2.0
	>=x11-misc/xdg-utils-1.0.2
	app-misc/ca-certificates
	net-misc/curl
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	live_preview? (
		|| ( www-client/chromium www-client/google-chrome )
	)"

S="${WORKDIR}"

src_prepare() {
	default

	# Fix: "FATAL:setuid_sandbox_host.cc(162)]
	#       The SUID sandbox helper binary was found, but is not configured correctly"
	chmod 4755 opt/brackets/chrome-sandbox || die "Failed to install!"

	# Fix: https://github.com/adobe/brackets/issues/13731
	#      https://github.com/adobe/brackets/issues/13738
	#
	# You need downgrade x11-libs/pango to 1.40.5 or download libpangoft2-1.0-0_1.40.5-1_****.deb
	if use amd64; then
		mv usr/lib/x86_64-linux-gnu/libpangoft2-1.0.so.0.4000.5 opt/brackets/ || die "Failed to install!"
	elif use x86; then
		mv usr/lib/i386-linux-gnu/libpangoft2-1.0.so.0.4000.5 opt/brackets/ || die "Failed to install!"
	fi

	# Cleanup
	rm -rf usr/share/menu usr/lib
}

src_install() {
	local my_pn="${PN%%-bin}"
	local s_libs="libnspr4.so.0d libplds4.so.0d libplc4.so.0d libssl3.so.1d \
		libnss3.so.1d libsmime3.so.1d libnssutil3.so.1d libudev.so.0"

	# Unfortunately, i can't fix warning message "QA Notice: The following files 
	# contain writable and executable sections"
	cp -Rp . "${D}"

	# Install symlinks (dev-libs/nss, dev-libs/nspr, dev-libs/openssl, etc...)
	for f in ${s_libs}; do
		target=$(echo ${f} | sed 's/\.[01]d\?$//')
		[ -f "/usr/lib/${target}" ] && dosym /usr/lib/${target} /opt/brackets/${f} || die "Failed to install!"
	done

	# Fix: https://github.com/adobe/brackets/issues/13731
	#      https://github.com/adobe/brackets/issues/13738
	dosym ./libpangoft2-1.0.so.0.4000.5 opt/brackets/libpangoft2-1.0.so.0 || die "Failed to install!"

	make_desktop_entry \
		"/usr/bin/${my_pn}" \
		"Brackets" \
		"${my_pn}" \
		"TextEditor;Development;" \
		"MimeType=text/html;\nKeywords=Text;Editor;Write;Web;Development;"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update

	elog
	elog "See documentation: https://github.com/adobe/brackets/wiki"
	elog
}

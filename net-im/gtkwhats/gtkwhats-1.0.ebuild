# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
atk-0.8.0
atk-sys-0.9.1
bitflags-1.2.1
cairo-rs-0.8.1
cairo-sys-rs-0.9.2
cc-1.0.54
futures-channel-0.3.5
futures-core-0.3.5
futures-executor-0.3.5
futures-io-0.3.5
futures-macro-0.3.5
futures-task-0.3.5
futures-util-0.3.5
gdk-0.12.1
gdk-pixbuf-0.8.0
gdk-pixbuf-sys-0.9.1
gdk-sys-0.9.1
gio-0.8.1
gio-sys-0.9.1
glib-0.9.3
glib-sys-0.9.1
gobject-sys-0.9.1
gtk-0.8.1
gtk-sys-0.9.2
javascriptcore-rs-0.9.0
javascriptcore-rs-sys-0.2.0
lazy_static-1.4.0
libc-0.2.71
once_cell-1.4.0
pango-0.8.0
pango-sys-0.9.1
pin-project-0.4.19
pin-project-internal-0.4.19
pin-utils-0.1.0
pkg-config-0.3.17
proc-macro-hack-0.5.16
proc-macro-nested-0.1.4
proc-macro2-1.0.18
quote-1.0.6
slab-0.4.2
soup-sys-0.9.0
syn-1.0.30
unicode-xid-0.2.0
webkit2gtk-0.9.2
webkit2gtk-sys-0.11.0"

inherit cargo desktop gnome2-utils xdg-utils

DESCRIPTION="Rust-based client for WhatsApp"
HOMEPAGE="https://github.com/gigitux/gtkwhats"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/glib:2
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango"
RDEPEND="${DEPEND}"

src_install() {
	cargo_src_install

	local app_id="com.gigitux.${PN}"

	domenu data/${app_id}.desktop
	doicon --size scalable data/${app_id}.svg

	insinto /usr/share/metainfo
	doins data/${app_id}.metainfo.xml

	insinto /usr/share/glib-2.0/schemas
	doins data/${app_id}.gschema.xml
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Hack to make Dropbox work on non-ext4 filesystems"
HOMEPAGE="https://github.com/dimaryaz/dropbox_ext4"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} == 99999999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="7cb936588ddd5992fb2c2c8f19b6015cf607a4f5"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND=">=net-misc/dropbox-62.4.102"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/make"

QA_PRESTRIPPED="/usr/lib/libdropbox_ext4.so"

src_prepare(){
	sed -i "s#/usr#/opt#" dropbox || die
	default_src_prepare
}

src_install(){
	# This little hack is because the Makefile cannot create those directories
	mkdir -p "${D}/usr/bin"
	mkdir -p "${D}/usr/lib"
	emake DESTDIR="${D}" INSTALL_DIR="${D}/usr" install
}

pkg_postinst(){
	echo
	einfo "In order to use dropbox with non-EXT4 filesystems, you must"
	einfo "restart the Dropbox application and/or daemon (if started)."
	einfo "The hack binary resides in /usr/bin/dropbox, and it's created"
	einfo "with this package, and does not the same as the bundled in"
	einfo "the original Dropbox package, since the non-EXT4 support"
	einfo "was dropped since November, 7th, 2018."
	echo
}

# Distributed under the terms of the GNU General Public License v2

EAPI=5

XORG_STATIC=no
inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xkeyboard-config"

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/XKeyboardConfig"
[[ ${PV} == *9999* ]] || SRC_URI="${XORG_BASE_INDIVIDUAL_URI}/data/${PN}/${P}.tar.bz2"

KEYWORDS="*"
IUSE="+nls"

LICENSE="MIT"
SLOT="0"

RDEPEND=">=x11-apps/xkbcomp-1.2.3
	>=x11-libs/libX11-1.4.3"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-libs/libxslt
	dev-util/intltool
	>=x11-proto/xproto-7.0.20"

XORG_CONFIGURE_OPTIONS=(
	--with-xkb-base="${EPREFIX}/usr/share/X11/xkb"
	--enable-compat-rules
	# do not check for runtime deps
	--disable-runtime-deps
	--with-xkb-rules-symlink=xorg
	$(use_enable nls)
)

PATCHES=(
	"${FILESDIR}"/evdev-dvorak.patch
	"${FILESDIR}"/latam-dvorak.patch
)

src_prepare() {
	xorg-2_src_prepare
	if [[ ${XORG_EAUTORECONF} != no ]]; then
		intltoolize --copy --automake || die
	fi
}

src_compile() {
	# cleanup to make sure .dir files are regenerated
	# bug #328455 c#26
	xorg-2_src_compile clean
	xorg-2_src_compile
}

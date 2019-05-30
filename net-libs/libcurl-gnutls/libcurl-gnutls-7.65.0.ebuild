# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools eutils prefix multilib-minimal

MY_PN="curl"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Curl libraries linked against gnutls for compatibility"
HOMEPAGE="https://curl.haxx.se/"
SRC_URI="https://curl.haxx.se/download/${MY_P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm arm64 hppa ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 ~sh sparc x86 ~ppc-aix ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="adns brotli http2 idn ipv6 kerberos ldap metalink rtmp samba ssh ssl static-libs test threads"

#lead to lots of false negatives, bug #285669
RESTRICT="test"

RDEPEND="ldap? ( net-nds/openldap[${MULTILIB_USEDEP}] )
	brotli? ( app-arch/brotli:=[${MULTILIB_USEDEP}] )
	net-libs/gnutls:0=[static-libs?,${MULTILIB_USEDEP}]
	dev-libs/nettle:0=[${MULTILIB_USEDEP}]
	app-misc/ca-certificates
	net-misc/curl[-curl_ssl_gnutls]
	http2? ( net-libs/nghttp2[${MULTILIB_USEDEP}] )
	idn? ( net-dns/libidn2:0=[static-libs?,${MULTILIB_USEDEP}] )
	adns? ( net-dns/c-ares:0[${MULTILIB_USEDEP}] )
	kerberos? ( >=virtual/krb5-0-r1[${MULTILIB_USEDEP}] )
	metalink? ( >=media-libs/libmetalink-0.1.1[${MULTILIB_USEDEP}] )
	rtmp? ( media-video/rtmpdump[${MULTILIB_USEDEP}] )
	ssh? ( net-libs/libssh2[${MULTILIB_USEDEP}] )
	sys-libs/zlib[${MULTILIB_USEDEP}]"

# Do we need to enforce the same ssl backend for curl and rtmpdump? Bug #423303
#	rtmp? (
#		media-video/rtmpdump
#		curl_ssl_gnutls? ( media-video/rtmpdump[gnutls] )
#		curl_ssl_openssl? ( media-video/rtmpdump[-gnutls,ssl] )
#	)

# ssl providers to be added:
# fbopenssl  $(use_with spnego)

DEPEND="${RDEPEND}
	>=virtual/pkgconfig-0-r1[${MULTILIB_USEDEP}]
	test? (
		sys-apps/diffutils
		dev-lang/perl
	)"

# c-ares must be disabled for threads
# only one ssl provider can be enabled
REQUIRED_USE="
	threads? ( !adns )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	eapply "${FILESDIR}"/${MY_PN}-7.30.0-prefix.patch
	eapply "${FILESDIR}"/${MY_PN}-respect-cflags-3.patch
	eapply "${FILESDIR}"/${MY_PN}-fix-gnutls-nettle.patch

	sed -i '/LD_LIBRARY_PATH=/d' configure.ac || die #382241
	sed -i '/CURL_MAC_CFLAGS/d' configure.ac || die #637252

	eapply_user
	eprefixify curl-config.in
	eautoreconf
}

multilib_src_configure() {
	# We make use of the fact that later flags override earlier ones
	# So start with all ssl providers off until proven otherwise
	# TODO: in the future, we may want to add wolfssl (https://www.wolfssl.com/)
	local myconf=()
	myconf+=( --with-gnutls --with-nettle --without-mbedtls --without-nss --without-polarssl --without-ssl --without-winssl )
	myconf+=( --without-ca-fallback --with-ca-bundle="${EPREFIX}"/etc/ssl/certs/ca-certificates.crt  )

	# These configuration options are organized alphabetically
	# within each category.  This should make it easier if we
	# ever decide to make any of them contingent on USE flags:
	# 1) protocols first.  To see them all do
	# 'grep SUPPORT_PROTOCOLS configure.ac'
	# 2) --enable/disable options second.
	# 'grep -- --enable configure | grep Check | awk '{ print $4 }' | sort
	# 3) --with/without options third.
	# grep -- --with configure | grep Check | awk '{ print $4 }' | sort
	ECONF_SOURCE="${S}" \
	econf \
		--disable-alt-svc \
		--enable-crypto-auth \
		--enable-dict \
		--enable-file \
		--enable-ftp \
		--enable-gopher \
		--enable-http \
		--enable-imap \
		$(use_enable ldap) \
		$(use_enable ldap ldaps) \
		--disable-ntlm-wb \
		--enable-pop3 \
		--enable-rt  \
		--enable-rtsp \
		$(use_enable samba smb) \
		$(use_with ssh libssh2) \
		--enable-smtp \
		--enable-telnet \
		--enable-tftp \
		--enable-tls-srp \
		$(use_enable adns ares) \
		--enable-cookies \
		--enable-hidden-symbols \
		$(use_enable ipv6) \
		--enable-largefile \
		--without-libpsl \
		--enable-manual \
		--enable-proxy \
		--disable-sspi \
		$(use_enable static-libs static) \
		$(use_enable threads threaded-resolver) \
		$(use_enable threads pthreads) \
		--disable-versioned-symbols \
		--without-amissl \
		--without-cyassl \
		--without-darwinssl \
		--without-fish-functions-dir \
		$(use_with idn libidn2) \
		$(use_with kerberos gssapi "${EPREFIX}"/usr) \
		$(use_with metalink libmetalink) \
		$(use_with http2 nghttp2) \
		$(use_with rtmp librtmp) \
		$(use_with brotli) \
		--without-schannel \
		--without-secure-transport \
		--without-spnego \
		--without-winidn \
		--without-wolfssl \
		--with-zlib \
		"${myconf[@]}"

	if ! multilib_is_native_abi; then
		# avoid building the client
		sed -i -e '/SUBDIRS/s:src::' Makefile || die
		sed -i -e '/SUBDIRS/s:scripts::' Makefile || die
	fi

	# Fix up the pkg-config file to be more robust.
	# https://github.com/curl/curl/issues/864
	local priv=() libs=()
	# We always enable zlib.
	libs+=( "-lz" )
	priv+=( "zlib" )
	if use http2; then
		libs+=( "-lnghttp2" )
		priv+=( "libnghttp2" )
	fi
	grep -q Requires.private libcurl.pc && die "need to update ebuild"
	libs=$(printf '|%s' "${libs[@]}")
	sed -i -r \
		-e "/^Libs.private/s:(${libs#|})( |$)::g" \
		libcurl.pc || die
	echo "Requires.private: ${priv[*]}" >> libcurl.pc
}

multilib_src_compile() {
	emake -C lib
}

multilib_src_install() {
	emake -C lib DESTDIR="${D}" install
}

multilib_src_install_all() {
	find "${ED}" -type f -name '*.la' -delete
	find "${ED}" -type l -name '*.so*' -delete
	rm -rf "${ED}"/etc/
	find "${ED}" -type f -name 'libcurl.so.4.5.0' -print0 |
		while IFS= read -d '' file_name; do
			mv "$file_name" "${file_name/.so.4.5.0/-gnutls.so.4.5.0}"
		done
	local version libdir
	for libdir in $(get_all_libdirs); do
		if [[ ${libdir} != "lib" ]]; then
			for version in 3 4 4.0.0 4.1.0 4.2.0 4.3.0 4.4.0; do
				dosym "${EROOT}"/usr/${libdir}/libcurl-gnutls.4.5.0 "${EROOT}"/usr/${libdir}/libcurl-gnutls.so.${version}
			done
		fi
	done
}

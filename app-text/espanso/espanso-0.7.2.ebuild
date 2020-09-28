# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
adler32-1.0.3
aho-corasick-0.7.6
ansi_term-0.11.0
arc-swap-0.4.7
arrayref-0.3.5
arrayvec-0.4.11
atty-0.2.13
autocfg-0.1.6
backtrace-0.3.37
backtrace-sys-0.1.31
base64-0.10.1
bitflags-1.1.0
blake2b_simd-0.5.7
byteorder-1.3.2
bytes-0.4.12
bzip2-0.3.3
bzip2-sys-0.1.7
c2-chacha-0.2.2
cc-1.0.45
cfg-if-0.1.9
chrono-0.4.9
clap-2.33.0
clicolors-control-1.0.1
cloudabi-0.0.3
cmake-0.1.42
console-0.9.0
constant_time_eq-0.1.4
cookie-0.12.0
cookie_store-0.7.0
core-foundation-0.6.4
core-foundation-sys-0.6.2
crc32fast-1.2.0
crossbeam-deque-0.7.1
crossbeam-epoch-0.7.2
crossbeam-queue-0.1.2
crossbeam-utils-0.6.6
dialoguer-0.4.0
dirs-2.0.2
dirs-sys-0.3.4
dtoa-0.4.4
either-1.5.3
encode_unicode-0.3.6
encoding_rs-0.8.20
error-chain-0.12.1
failure-0.1.5
failure_derive-0.1.5
filetime-0.2.9
flate2-1.0.11
fnv-1.0.6
foreign-types-0.3.2
foreign-types-shared-0.1.1
fs2-0.4.3
fsevent-0.4.0
fsevent-sys-2.0.1
fuchsia-cprng-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.29
futures-cpupool-0.1.8
getrandom-0.1.12
h2-0.1.26
http-0.1.18
http-body-0.1.0
httparse-1.3.4
hyper-0.12.35
hyper-tls-0.3.2
idna-0.1.5
idna-0.2.0
indexmap-1.2.0
inotify-0.7.0
inotify-sys-0.1.3
iovec-0.1.2
itoa-0.4.4
kernel32-sys-0.2.2
lazy_static-1.4.0
lazycell-1.2.1
libc-0.2.62
linked-hash-map-0.5.2
lock_api-0.1.5
log-0.4.8
log-panics-2.0.0
matches-0.1.8
memchr-2.2.1
memoffset-0.5.1
mime-0.3.14
mime_guess-2.0.1
miniz_oxide-0.3.2
mio-0.6.19
mio-extras-2.0.6
miow-0.2.1
named_pipe-0.4.1
native-tls-0.2.3
net2-0.2.33
nodrop-0.1.13
notify-4.0.15
num-integer-0.1.41
num-traits-0.2.8
num_cpus-1.10.1
openssl-0.10.24
openssl-probe-0.1.2
openssl-sys-0.9.49
owning_ref-0.4.0
parking_lot-0.7.1
parking_lot_core-0.4.0
percent-encoding-1.0.1
percent-encoding-2.1.0
pkg-config-0.3.16
podio-0.1.6
ppv-lite86-0.2.5
proc-macro2-0.4.30
proc-macro2-1.0.2
publicsuffix-1.5.3
quote-0.6.13
quote-1.0.2
rand-0.6.5
rand-0.7.2
rand_chacha-0.1.1
rand_chacha-0.2.1
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_hc-0.1.0
rand_hc-0.2.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
rdrand-0.4.0
redox_syscall-0.1.56
redox_users-0.3.1
regex-1.3.1
regex-syntax-0.6.12
remove_dir_all-0.5.2
reqwest-0.9.20
rust-argon2-0.5.1
rustc-demangle-0.1.16
rustc_version-0.2.3
ryu-1.0.0
same-file-1.0.5
schannel-0.1.16
scopeguard-0.3.3
scopeguard-1.0.0
security-framework-0.3.1
security-framework-sys-0.3.1
semver-0.9.0
semver-parser-0.7.0
serde-1.0.99
serde_derive-1.0.99
serde_json-1.0.40
serde_urlencoded-0.5.5
serde_yaml-0.8.9
signal-hook-0.1.15
signal-hook-registry-1.2.0
simplelog-0.7.1
slab-0.4.2
smallvec-0.6.10
stable_deref_trait-1.1.1
string-0.2.1
strsim-0.8.0
syn-0.15.44
syn-1.0.5
synstructure-0.10.2
tempfile-3.1.0
term-0.6.1
termios-0.3.1
textwrap-0.11.0
thread_local-0.3.6
time-0.1.42
tokio-0.1.22
tokio-buf-0.1.1
tokio-current-thread-0.1.6
tokio-executor-0.1.8
tokio-io-0.1.12
tokio-reactor-0.1.9
tokio-sync-0.1.6
tokio-tcp-0.1.3
tokio-threadpool-0.1.15
tokio-timer-0.2.11
try-lock-0.2.2
try_from-0.3.2
unicase-2.5.1
unicode-bidi-0.3.4
unicode-normalization-0.1.8
unicode-width-0.1.6
unicode-xid-0.1.0
unicode-xid-0.2.0
url-1.7.2
url-2.1.0
uuid-0.7.4
vcpkg-0.2.7
vec_map-0.8.1
version_check-0.1.5
walkdir-2.2.9
want-0.2.0
wasi-0.7.0
widestring-0.4.0
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.2
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
ws2_32-sys-0.2.1
yaml-rust-0.4.3
zip-0.5.3"

inherit cargo systemd

DESCRIPTION="Cross-platform text expander written in Rust"
HOMEPAGE="https://espanso.org"
SRC_URI="https://github.com/federico-terzi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND="
	x11-libs/libnotify
	x11-libs/libXtst
	x11-misc/xclip
	x11-misc/xdotool
	systemd? ( sys-apps/systemd )"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"

src_prepare() {
	if use systemd; then
		cp src/res/linux/systemd.service ${PN}.service
		sed -i -e "s|{{{espanso_path}}}|/usr/bin/espanso|g" \
			${PN}.service
	fi

	default
}

src_install() {
	cargo_src_install

	use systemd && systemd_douserunit ${PN}.service
}

pkg_postinst() {
	echo
	elog "Thanks for installing ${PN}."
	elog "The service can be started as an user with:"
	echo
	elog "${PN} start"
	echo
	elog "And stop it with:"
	echo
	elog "${PN} stop"
	echo
	elog "Also you can do this:"
	echo
	elog "${PN} status"
	echo
	elog "to see the status of the service."
	if use systemd; then
		echo
		elog "To start ${PN} automatically when you log in,"
		elog "enable the systemd user service:"
		elog "${PN} register"
	fi
	echo
}

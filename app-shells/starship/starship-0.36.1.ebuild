# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.8
ansi_term-0.11.0
ansi_term-0.12.1
anyhow-1.0.26
arrayref-0.3.6
arrayvec-0.4.12
arrayvec-0.5.1
atty-0.2.14
autocfg-0.1.7
autocfg-1.0.0
base64-0.10.1
base64-0.11.0
battery-0.7.5
bitflags-1.2.1
blake2b_simd-0.5.10
bumpalo-3.2.0
byte-unit-3.0.3
byteorder-1.3.4
bytes-0.5.4
c2-chacha-0.2.3
cc-1.0.50
cfg-if-0.1.10
chrono-0.4.10
clap-2.33.0
constant_time_eq-0.1.5
core-foundation-0.6.4
core-foundation-sys-0.6.2
crossbeam-deque-0.7.2
crossbeam-epoch-0.8.0
crossbeam-queue-0.2.1
crossbeam-utils-0.7.0
ct-logs-0.6.0
dirs-2.0.2
dirs-sys-0.3.4
doc-comment-0.3.1
dtoa-0.4.5
either-1.5.3
encoding_rs-0.8.22
env_logger-0.7.1
fnv-1.0.6
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-channel-0.3.4
futures-core-0.3.4
futures-io-0.3.4
futures-macro-0.3.4
futures-sink-0.3.4
futures-task-0.3.4
futures-util-0.3.4
gethostname-0.2.1
getrandom-0.1.14
git2-0.11.0
h2-0.2.1
heck-0.3.1
hermit-abi-0.1.7
http-0.2.0
http-body-0.3.1
httparse-1.3.4
humantime-1.3.0
hyper-0.13.2
hyper-rustls-0.19.1
idna-0.2.0
indexmap-1.3.2
iovec-0.1.4
itoa-0.4.5
jobserver-0.1.21
js-sys-0.3.35
kernel32-sys-0.2.2
lazy_static-1.4.0
lazycell-1.2.1
lexical-core-0.4.6
libc-0.2.66
libgit2-sys-0.10.0
libz-sys-1.0.25
linked-hash-map-0.5.2
log-0.4.8
mach-0.2.3
matches-0.1.8
memchr-2.3.2
memoffset-0.5.3
mime-0.3.16
mime_guess-2.0.1
mio-0.6.21
miow-0.2.1
net2-0.2.33
nix-0.15.0
nodrop-0.1.14
nom-4.2.3
nom-5.1.0
ntapi-0.3.3
num-integer-0.1.42
num-traits-0.2.11
num_cpus-1.12.0
once_cell-1.3.1
open-1.3.4
openssl-probe-0.1.2
os_info-2.0.0
path-slash-0.1.1
percent-encoding-2.1.0
pin-project-0.4.8
pin-project-internal-0.4.8
pin-project-lite-0.1.4
pin-utils-0.1.0-alpha.4
pkg-config-0.3.17
ppv-lite86-0.2.6
pretty_env_logger-0.4.0
proc-macro-hack-0.5.11
proc-macro-nested-0.1.3
proc-macro2-1.0.8
quick-error-1.2.3
quote-1.0.2
rand-0.7.3
rand_chacha-0.2.1
rand_core-0.5.1
rand_hc-0.2.0
rayon-1.3.0
rayon-core-1.7.0
redox_syscall-0.1.56
redox_users-0.3.4
regex-1.3.4
regex-syntax-0.6.14
remove_dir_all-0.5.2
reqwest-0.10.1
ring-0.16.11
rust-argon2-0.7.0
rustc_version-0.2.3
rustls-0.16.0
rustls-native-certs-0.1.0
ryu-1.0.2
schannel-0.1.17
scopeguard-1.1.0
sct-0.6.0
security-framework-0.3.4
security-framework-sys-0.3.3
semver-0.9.0
semver-parser-0.7.0
serde-1.0.104
serde_derive-1.0.104
serde_json-1.0.48
serde_urlencoded-0.6.1
slab-0.4.2
smallvec-1.2.0
sourcefile-0.1.4
spin-0.5.2
static_assertions-0.3.4
strsim-0.8.0
syn-1.0.14
sysinfo-0.11.2
tempfile-3.1.0
term_size-0.3.1
termcolor-1.1.0
textwrap-0.11.0
thread_local-1.0.1
time-0.1.42
tokio-0.2.11
tokio-rustls-0.12.2
tokio-util-0.2.0
toml-0.5.6
tower-service-0.3.0
try-lock-0.2.2
typenum-1.11.2
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.12
unicode-segmentation-1.6.0
unicode-width-0.1.7
unicode-xid-0.2.0
untrusted-0.7.0
uom-0.26.0
url-2.1.1
urlencoding-1.0.0
vcpkg-0.2.8
vec_map-0.8.1
version_check-0.1.5
version_check-0.9.1
void-1.0.2
want-0.3.0
wasi-0.9.0+wasi-snapshot-preview1
wasm-bindgen-0.2.58
wasm-bindgen-backend-0.2.58
wasm-bindgen-futures-0.4.8
wasm-bindgen-macro-0.2.58
wasm-bindgen-macro-support-0.2.58
wasm-bindgen-shared-0.2.58
wasm-bindgen-webidl-0.2.58
web-sys-0.3.35
webpki-0.21.2
webpki-roots-0.17.0
weedle-0.10.0
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.3
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
ws2_32-sys-0.2.1
yaml-rust-0.4.3"

inherit cargo

DESCRIPTION="The cross-shell prompt for astronauts"
HOMEPAGE="https://starship.rs"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/starship/starship/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

DEPEND="
	dev-libs/openssl:0
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

DOCS="docs/README.md"

src_install() {
	# Can't install as a cargo package,
	# let's do this manually.
	dobin target/release/${PN}
	default
}

pkg_postinst() {
	echo
	elog "Thanks for installing starship."
	elog "For better experience, it's suggested to install some Powerline font."
	elog "You can get some from https://github.com/powerline/fonts"
	echo
}

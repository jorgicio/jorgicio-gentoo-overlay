# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.6
ansi_term-0.11.0
ansi_term-0.12.1
argon2rs-0.2.5
arrayvec-0.4.10
atty-0.2.11
autocfg-0.1.2
backtrace-0.3.15
backtrace-sys-0.1.28
battery-0.7.4
bitflags-1.1.0
blake2-rfc-0.2.18
c2-chacha-0.2.2
cc-1.0.45
cfg-if-0.1.7
chrono-0.4.9
clap-2.33.0
cloudabi-0.0.3
constant_time_eq-0.1.3
core-foundation-0.6.4
core-foundation-sys-0.6.2
crossbeam-deque-0.7.1
crossbeam-epoch-0.7.2
crossbeam-queue-0.1.2
crossbeam-utils-0.6.5
dirs-2.0.2
dirs-sys-0.3.4
either-1.5.2
env_logger-0.6.2
failure-0.1.5
failure_derive-0.1.5
fuchsia-cprng-0.1.1
gethostname-0.2.0
getrandom-0.1.12
git2-0.10.1
humantime-1.2.0
idna-0.2.0
itoa-0.4.4
jobserver-0.1.17
lazy_static-1.4.0
lazycell-1.2.1
libc-0.2.62
libgit2-sys-0.9.1
libz-sys-1.0.25
log-0.4.8
mach-0.2.3
matches-0.1.8
memchr-2.2.1
memoffset-0.5.1
nix-0.14.0
nodrop-0.1.13
num-integer-0.1.39
num-traits-0.2.6
num_cpus-1.10.0
numtoa-0.1.0
once_cell-1.1.0
path-slash-0.1.1
percent-encoding-2.0.0
pkg-config-0.3.14
ppv-lite86-0.2.5
pretty_env_logger-0.3.1
proc-macro2-0.4.30
quick-error-1.2.2
quote-0.6.12
rand-0.7.0
rand_chacha-0.2.0
rand_core-0.3.1
rand_core-0.4.0
rand_core-0.5.0
rand_hc-0.2.0
rand_os-0.1.3
rayon-1.2.0
rayon-core-1.6.0
rdrand-0.4.0
redox_syscall-0.1.54
redox_termios-0.1.1
redox_users-0.3.0
regex-1.3.1
regex-syntax-0.6.12
remove_dir_all-0.5.1
rustc-demangle-0.1.14
rustc_version-0.2.3
ryu-1.0.0
scoped_threadpool-0.1.9
scopeguard-1.0.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.98
serde_json-1.0.40
smallvec-0.6.10
strsim-0.8.0
syn-0.15.34
synstructure-0.10.1
tempfile-3.1.0
termcolor-1.0.4
termion-1.5.2
textwrap-0.11.0
thread_local-0.3.6
time-0.1.42
toml-0.5.3
typenum-1.10.0
unicode-bidi-0.3.4
unicode-normalization-0.1.8
unicode-segmentation-1.3.0
unicode-width-0.1.5
unicode-xid-0.1.0
uom-0.23.0
url-2.0.0
vcpkg-0.2.6
vec_map-0.8.1
void-1.0.2
wasi-0.7.0
winapi-0.3.7
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.2
winapi-x86_64-pc-windows-gnu-0.4.0
wincolor-1.0.1"

inherit cargo

DESCRIPTION="The cross-shell prompt for astronauts"
HOMEPAGE="https://starship.rs"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/starship/starship/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE=""

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

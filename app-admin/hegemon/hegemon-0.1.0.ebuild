# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.6.8
bit-set-0.4.0
bit-vec-0.4.4
bitflags-1.0.4
bytesize-0.1.3
cfg-if-0.1.5
chan-0.1.23
chan-signal-0.3.2
chrono-0.4.6
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
${P}
lazy_static-0.2.11
lazy_static-1.1.0
libc-0.2.43
libsensors-sys-0.2.0
memchr-1.0.2
memchr-2.1.0
nom-3.2.1
num-integer-0.1.39
num-traits-0.2.6
rand-0.3.22
rand-0.4.3
redox_syscall-0.1.40
redox_termios-0.1.1
regex-1.0.5
regex-syntax-0.6.2
sensors-0.2.1
systemstat-0.1.3
termion-1.5.1
thread_local-0.3.6
time-0.1.40
ucd-util-0.1.1
utf8-ranges-1.0.1
version_check-0.1.4
winapi-0.3.6
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="A modular system monitor written in Rust"
HOMEPAGE="https://github.com/p-e-w/hegemon"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/lm_sensors"
RDEPEND="${DEPEND}"
BDEPEND=">=virtual/rust-1.2.6"

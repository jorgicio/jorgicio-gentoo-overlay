# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="5-progress"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"

inherit distutils multilib-minimal

DESCRIPTION="Python implementation of subunit test streaming protocol"
HOMEPAGE="https://launchpad.net/subunit https://pypi.python.org/pypi/python-subunit"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="|| ( Apache-2.0 BSD )"
SLOT="0"
KEYWORDS="*"
IUSE="test static-libs"

RDEPEND="$(python_abi_depend dev-python/extras)
	$(python_abi_depend ">=dev-python/testtools-0.9.34")"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	dev-lang/perl:=
	>=dev-libs/check-0.9.11[${MULTILIB_USEDEP}]
	>=dev-util/cppunit-1.13.2[${MULTILIB_USEDEP}]
	>=virtual/pkgconfig-0-r1[${MULTILIB_USEDEP}]
	test? ( $(python_abi_depend dev-python/testscenarios) )"

src_prepare() {
	epatch "${FILESDIR}"/1.0.0-tests.patch
	sed -i -e 's/os.chdir(os.path.dirname(__file__))//' setup.py || die
	export INSTALLDIRS=vendor
	distutils_src_prepare
	multilib_copy_sources
}

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		--enable-shared \
		$(use_enable static-libs static)
}

multilib_src_compile() {
	default
	multilib_is_native_abi && distutils_src_compile
}

src_test() {
	testing() {
		python_execute PYTHONPATH="python" "$(PYTHON)" -m testtools.run subunit.test_suite
	}
	python_execute_function testing
}

multilib_src_test() {
	multilib_is_native_abi && distutils_src_test
}

multilib_src_install() {
		local targets=(
		install-include_subunitHEADERS
		install-pcdataDATA
		install-exec-local
		install-libLTLIBRARIES
	)
	emake DESTDIR="${D}" "${targets[@]}"
	multilib_is_native_abi && distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/subunit/tests"
	}
	python_execute_function -q delete_tests
}

multilib_src_install_all(){
	einstalldocs
	prune_libtool_files
}

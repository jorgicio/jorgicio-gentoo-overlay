# Copyright 2018 Martin V\"ath
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: required-use-warn.eclass
# @MAINTAINER:
# Martin Väth <martin@mvath.de>
# @SUPPORTED_EAPIS: 0 1 2 3 4 5 6 7
# @BLURB: This eclass support REQUIRED_USE_WARN
# @DESCRIPTION:
# The eclass provides support for REQUIRED_USE_WARN.
# REQUIRED_USE_WARN is similar to REQUIRED_USE except that only warnings are
# are printed if a condition is violated.
# The only supported conditions are of the type
#   FLAG
#   !FLAG
#   A? ( B C ... )
# where each of A B C ... are of some of the 3 types.
# @EXAMPLE:
# To warn that USE=bazola is ignored (if USE="foo -bar bazola" is active)
# and that USE=BAR is implicitly enabled (if USE="FOO -BAR" is active) use:
# @CODE
# inherit required-use-warn
#
# REQUIRED_USE_WARN="foo? ( !bar? ( !bazola ) ) !FOO? ( BAR )
# pkg_pretend() {
# 	required-use-warn
# }

# @FUNCTION: required-use-warn_internal
# @USAGE: string
# @INTERNAL
# @DESCRIPTION:
# Print warnings according to the passed normalized string.
# Normalized means only spaces, none superfluous
required-use-warn_internal() {
	local first curr cond negate satisfied rest second open pass brace
	[ -n "${1}" ] || return 0
	first=${1%%' '*}
	if [ "${first}" = "${1}" ]; then
		rest=
	else
		rest=${1#*' '}
	fi
	cond=${first#'!'}
	[ "${cond}" = "${first}" ] && negate=false || negate=:
	curr=${cond%'?'}
	[ "${curr}" = "${cond}" ] && cond=false || cond=:
	satisfied=false
	if use "${curr}"; then
		${negate} || satisfied=:
	else
		! ${negate} || satisfied=:
	fi
	if ! $cond; then
		if ! ${satisfied}; then
			if ${negate}; then
				ewarn "Ignoring USE=${curr} for ${CATEGORY}/${PN}"
			else
				ewarn "Implicitly enabling USE=${curr} for ${CATEGORY}/${PN}"
			fi
		fi
		required-use-warn_internal "${rest}"
		return 0
	fi
	second=${rest#'( '}
	[ "${second}" != "${rest}" ] || die "no opening brace after ${first}"
	rest=${second}
	pass=
	open=1
	while :; do
		second=${rest%%' '[()]*}
		[ "${second}" != "${rest}" ] || die "wrong bracing after ${first}"
		pass=${pass}${second}
		brace=${rest#"${second}"}
		rest=${brace#' '?}
		case ${brace} in
		' ('*)
			pass=${pass}' ('
			: $(( ++open ));;
		' )'*)
			: $(( --open ))
			[ $open -eq 0 ] && break
			pass=${pass}' )'
		esac
	done
	! ${satisfied} || required-use-warn_internal "${pass}"
	rest=${rest#' '}
	required-use-warn_internal "${rest}"
}

# @FUNCTION: required-use-warn
# @USAGE: [string]
# @INTERNAL
# @DESCRIPTION:
# Print warnings according to the passed string (default is REQUIRED_USE_WARN)
required-use-warn() {
	local normalized i
	if [ ${#} -eq 0 ]; then
		normalized=${REQUIRED_USE_WARN}
	else
		normalized=${1}
	fi
	normalized=${normalized//[[:space:]]/' '}
	while i=${normalized//'  '/' '} && [ "${i}" != "${normalized}" ]; do
		normalized=${i}
	done
	normalized=${normalized%' '}
	normalized=${normalized#' '}
	required-use-warn_internal "${normalized}"
}

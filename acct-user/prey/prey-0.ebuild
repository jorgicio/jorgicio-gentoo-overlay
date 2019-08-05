# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="Prey program user"
ACCT_USER_ID=999
ACCT_USER_GROUPS=( prey )
acct-user_add_deps
KEYWORDS="~amd64 ~x86"

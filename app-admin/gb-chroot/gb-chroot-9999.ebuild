# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PF4Public/gb-chroot.git"
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="https://github.com/PF4Public/gb-chroot/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="gb-chroot is a collection of scripts for building Gentoo's binpkgs"
HOMEPAGE="https://pf4public.github.io/gb-chroot/"

LICENSE="MIT"
SLOT="0"
IUSE="doc host"

DOCS=( README.md )

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install()
{
	if use doc
	then
		DOCS+=( docs/index.md )
	fi
	einstalldocs

	if use host
	then
		doconfd config/gb-chroot
		doinitd scripts/gb-chroot
		dobin scripts/gb-all scripts/gb-enter scripts/gb-mount scripts/gb-install scripts/gb-update-host
		keepdir /var/lib/gb-chroot
		insinto /usr/share/gb-chroot
		doins templates/*
	else
		dobin scripts/gb-update-chroot
		dobin scripts/gb-update-target
	fi
}

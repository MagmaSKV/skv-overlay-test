# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3 systemd

DESCRIPTION="Hardware PS4 FAN control util"
HOMEPAGE="https://github.com/MagmaSKV/ps4fancontrol"

EGIT_REPO_URI="https://github.com/MagmaSKV/ps4fancontrol.git"

LICENSE="GPL-2+ LGPL-2.1"
SLOT="0"

#KEYWORDS="~amd64"
KEYWORDS=""
IUSE="libnotify systemd kde X"
RDEPEND="
	dev-libs/glib:2
	systemd? ( sys-apps/systemd:= )
	x11-libs/gtk+:3[X]
	x11-libs/libX11
	libnotify? ( >=x11-libs/libnotify-0.7 )"
DEPEND="${RDEPEND}
	>=x11-libs/xforms-1.2.4-r1"

src_install() {
	if use systemd; then
		systemd_newunit "${FILESDIR}"/ps4fancontrol.service ps4fancontrol.service
		systemd_newunit "${FILESDIR}"/ps4fancontrol-reset.service ps4fancontrol-reset.service
		systemd_install_serviced "${FILESDIR}"/ps4fancontrol.service.conf
	else
		newconfd "${FILESDIR}"/ps4fancontrol.conf.d ps4fancontrol
		newinitd "${FILESDIR}"/ps4fancontrol.initd ps4fancontrol
	fi

	into /
	dosbin ps4fancontrol
	domenu "${FILESDIR}/ps4fancontrol.desktop"
}

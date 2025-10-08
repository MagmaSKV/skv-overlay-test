# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Linux System Optimizer and Monitoring"
HOMEPAGE="https://github.com/MagmaSKV/Stacer"
SRC_URI="https://github.com/MagmaSKV/Stacer/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcharts
    dev-qt/qtconcurrent
    dev-qt/qtnetwork
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/Stacer-${PV}"

src_install() {
    default
    dobin ${BUILD_DIR}/output/stacer

    insinto /usr/share/icons/
    cp -r "${S}"/icons/* "${ED}"/usr/share/icons

    insinto /usr/share/applications/
    doins applications/stacer.desktop
}

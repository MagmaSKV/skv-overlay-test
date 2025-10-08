EAPI=8
inherit cmake

DESCRIPTION="Linux System Optimizer and Monitoring (Qt6)"
HOMEPAGE="https://github.com/MagmaSKV/Stacer"
SRC_URI="https://github.com/MagmaSKV/Stacer/archive/refs/tags/v1.1.0-qt6.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcharts
    dev-qt/qtconcurrent
    dev-qt/qtnetwork
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/Stacer-1.1.0-qt6"

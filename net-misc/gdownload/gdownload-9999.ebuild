EAPI=8

DESCRIPTION="GDownloader: GUI Download Manager built with Java"
HOMEPAGE="https://github.com/hstr0100/GDownloader"
SRC_URI="git+https://github.com/hstr0100/GDownloader.git"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
    >=dev-java/openjdk-21
    dev-java/gradle-bin
    media-video/ffmpeg
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/GDownloader"

src_prepare() {
    default
    chmod +x ./gradlew
}

src_compile() {
    ./gradlew clean build jpackage
}

src_install() {
    local install_dir="${D}/opt/gdownload"
    mkdir -p "${install_dir}"
    cp -r build/jpackage/* "${install_dir}/"

    local bin_dir="${D}/usr/bin"
    mkdir -p "${bin_dir}"
    ln -s /opt/gdownload/GDownloader "${bin_dir}/gdownload"
}
EAPI=8

DESCRIPTION="GDownloader: GUI Download Manager built with Java"
HOMEPAGE="https://github.com/hstr0100/GDownloader"

# Live Git ebuild
SRC_URI="git+https://github.com/hstr0100/GDownloader.git"
EGIT_REPO_URI="https://github.com/hstr0100/GDownloader.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Dependencias
DEPEND="
    >=dev-java/openjdk-21
    dev-java/gradle-bin
    media-video/ffmpeg
"

RDEPEND="${DEPEND}"

# Portage define S automáticamente como ${WORKDIR}/${PN}-${PV}
# Pero para live ebuilds a veces el repo clona en WORKDIR directamente
# Así que dejamos S como WORKDIR
S="${WORKDIR}"

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
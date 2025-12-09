# /usr/local/portage/net-misc/gdownload/gdownload-0.1.ebuild
EAPI=8

DESCRIPTION="GDownloader: GUI Download Manager built with Java"
HOMEPAGE="https://github.com/hstr0100/GDownloader"
SRC_URI="git+https://github.com/hstr0100/GDownloader.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Dependencias de tiempo de compilación y ejecución
DEPEND="
    >=dev-java/openjdk-21
    dev-java/gradle-bin
    media-video/ffmpeg
"

RDEPEND="${DEPEND}"

# Gradle utiliza gradlew que ya viene con el proyecto
S="${WORKDIR}/GDownloader"

src_prepare() {
    default
    # Asegurarse de que gradlew tenga permisos de ejecución
    chmod +x ./gradlew
}

src_compile() {
    # Construcción usando gradlew
    ./gradlew clean build jpackage
}

src_install() {
    # Instalar el paquete generado por jpackage
    # Por defecto, jpackage genera un .deb, .rpm o directorio de instalación
    # Vamos a copiar la carpeta "GDownloader" generada en build/jpackage
    local install_dir="${D}/opt/gdownload"
    mkdir -p "${install_dir}"
    cp -r build/jpackage/* "${install_dir}/"
    
    # Crear un enlace simbólico en /usr/bin para facilitar ejecución
    local bin_dir="${D}/usr/bin"
    mkdir -p "${bin_dir}"
    ln -s /opt/gdownload/GDownloader "${bin_dir}/gdownload"
}

pkg_postinst() {
    einfo "GDownloader instalado en /opt/gdownload"
    einfo "Ejecuta 'gdownload' para iniciar la aplicación"
}

# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GDownloader 1.5.12 - GUI Downloader (portable, prebuilt)"
HOMEPAGE="https://github.com/hstr0100/GDownloader"
SRC_URI="https://github.com/hstr0100/GDownloader/releases/download/v1.5.12/gdownloader-1.5.12-linux_portable_amd64.zip"
DISTFILES="${SRC_URI}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
S="${WORKDIR}"

DEPEND="virtual/jdk:21"
RDEPEND="${DEPEND}"

src_prepare() {
    # Nothing to patch or prepare, portable release
    default
}

src_unpack() {
    # Unpack the portable zip directly into WORKDIR
    unzip "${DISTDIR}/gdownloader-1.5.12-linux_portable_amd64.zip" -d "${WORKDIR}" || die "Failed to unpack portable zip"
}

src_compile() {
    # No compilation needed
    return 0
}

src_install() {
    # Instalamos la app en /opt/GDownloader
    insinto /opt/GDownloader
    doins -r "${WORKDIR}/lib/"* || die "Failed to install lib files"
    doins -r "${WORKDIR}/bin/"* || die "Failed to install bin files"

    # Crear wrapper en /usr/bin
    make_wrapper /usr/bin/gdownloader /opt/GDownloader/runtime/bin/GDownloader \
        WORKDIR /opt/GDownloader \
        APP_NAME "GDownloader"

    # Instalar el .desktop para menú
    insinto /usr/share/applications
    doins "${WORKDIR}/lib/app/GDownloader.desktop" || die "Failed to install desktop file"

    # Icono
    insinto /usr/share/icons/hicolor/256x256/apps
    doins "${WORKDIR}/lib/app/GDownloader.png" || die "Failed to install icon"
}

pkg_postinst() {
    # Actualiza la base de datos de menús
    if type update-desktop-database >/dev/null 2>&1; then
        update-desktop-database -q
    fi

    # Actualiza la caché de iconos
    if type gtk-update-icon-cache >/dev/null 2>&1; then
        gtk-update-icon-cache -f -q /usr/share/icons/hicolor
    fi
}
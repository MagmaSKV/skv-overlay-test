# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI=8


DESCRIPTION="GDownloader 1.5.12 - GUI Downloader prebuilt bundle"
HOMEPAGE="https://github.com/hstr0100/GDownloader"
SRC_URI="https://github.com/hstr0100/GDownloader/releases/download/v1.5.12/gdownloader-1.5.12-linux_portable_amd64.zip"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"


DEPEND="virtual/jdk:21"
RDEPEND="${DEPEND}"


src_unpack() {
unzip ${DISTDIR}/$(basename ${SRC_URI}) -d "${WORKDIR}" || die "Failed to unzip"
}


src_install() {
# Install everything into /opt/GDownloader
insinto /opt/GDownloader
doins -r "${WORKDIR}/gdownloader-1.5.12-linux_portable_amd64" || die


# Make wrapper script
make_wrapper /usr/bin/gdownloader "/opt/GDownloader/GDownloader" "/opt/GDownloader"


# Install .desktop file
insinto /usr/share/applications
einstalldesktop gdownloader.desktop || die


# Install icon if exists
insinto /usr/share/pixmaps
doins /opt/GDownloader/icon.png || true
}
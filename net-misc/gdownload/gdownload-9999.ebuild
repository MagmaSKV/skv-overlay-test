# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GDownloader - GUI Downloader built with Java and Gradle"
HOMEPAGE="https://github.com/hstr0100/GDownloader"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

EGIT_REPO_URI="https://github.com/hstr0100/GDownloader.git"
inherit git-r3 java-pkg-2

DEPEND="
    virtual/jdk:21
    media-video/ffmpeg
    dev-java/gradle-bin
"
RDEPEND="${DEPEND}"

src_prepare() {
    default

    # Remove jlink plugin to avoid remote Gradle Plugin Portal access
    sed -i "s/id 'org.beryx.jlink'//" core/build.gradle || die
    sed -i "/org.beryx.jlink/d" settings.gradle || die

    # Remove Gradle wrapper to prevent downloads
    rm -f gradlew || die
    rm -rf gradle/wrapper || die
    find . -name '*wrapper*' -exec rm -f {} + || die
}

src_compile() {
    export GRADLE_USER_HOME="${WORKDIR}/gradle-cache"

    gradle --no-daemon clean build jpackage || die "Gradle build failed"
}

src_install() {
    insinto /opt/GDownloader
    doins -r build/* || die

    make_wrapper gdownloader "/opt/GDownloader/jpackage/GDownloader/bin/GDownloader"
}
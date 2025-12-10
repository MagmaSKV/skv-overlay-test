# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="source"

DESCRIPTION="GDownloader - GUI Downloader built with Java and Gradle"
HOMEPAGE="https://github.com/hstr0100/GDownloader"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Using git as source
EGIT_REPO_URI="https://github.com/hstr0100/GDownloader.git"
inherit git-r3 java-pkg-2

# Dependencies
DEPEND="
    virtual/jdk:21
    media-video/ffmpeg
    dev-java/gradle-bin
"
RDEPEND="${DEPEND}"

src_prepare() {
    default
}

src_compile() {
    # Use local Gradle cache
    export GRADLE_USER_HOME="${WORKDIR}/gradle-cache"

    # Hard-remove ALL Gradle wrapper components to prevent network downloads
    rm -f gradlew || die
    rm -f gradle/wrapper/gradle-wrapper.jar || die
    rm -f gradle/wrapper/gradle-wrapper.properties || die
    rm -rf gradle/wrapper || die

    # Ensure no wrapper jars remain anywhere
    find . -name '*wrapper*' -exec rm -f {} +

    # Use system gradle-bin
    gradle --no-daemon clean build jpackage || die "Gradle build failed"
}/gradle-cache"

    # Remove Gradle wrapper to prevent network downloads
    rm -f gradlew || die
    rm -rf gradle/wrapper || die

    # Use system gradle-bin
    gradle --no-daemon clean build jpackage || die "Gradle build failed"
}/gradle-cache"

    # Do NOT use the Gradle wrapper (it tries to download Gradle)
    # Use system gradle-bin instead
    gradle --no-daemon clean build jpackage || die "Gradle build failed"
}/gradle-cache"

    gradle --no-daemon clean build jpackage || die "Gradle build failed"
}

src_install() {
    # Install built artifacts
    insinto /opt/GDownloader
    doins -r build/* || die

    # Provide launcher
    make_wrapper gdownloader "/opt/GDownloader/jpackage/GDownloader/bin/GDownloader"
}

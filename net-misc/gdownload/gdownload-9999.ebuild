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
# build with gradle
./gradlew clean build jpackage || die "Gradle build failed"
}


src_install() {
# Install built artifacts
insinto /opt/GDownloader
doins -r build/* || die


# Provide launcher
make_wrapper gdownloader "/opt/GDownloader/jpackage/GDownloader/bin/GDownloader"
}
# Copyright 2024 Gentoo
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 cargo

DESCRIPTION="A graphical interface for distrobox"
HOMEPAGE="https://github.com/ranfdev/DistroShelf"
EGIT_REPO_URI="https://github.com/ranfdev/DistroShelf.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
    app-containers/distrobox
    dev-libs/glib:2
    gui-libs/gtk:4
    gui-libs/libadwaita
    dev-lang/rust
"
RDEPEND="${DEPEND}"

# Cargo necesita descargar crates antes de compilar
CARGO_FETCH_CRATES=yes

src_unpack() {
    git-r3_src_unpack
    cargo_src_unpack
}

src_configure() {
    meson_src_configure --prefix=/usr
}

src_compile() {
    cargo_src_compile
    meson_src_compile
}

src_install() {
    meson_src_install
}

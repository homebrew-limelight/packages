cd rusty-engine

# Install Rust #
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable --profile minimal -y
## Install cargo-deb ##
cargo install cargo-deb

# FIXME: hardcoded master archive should be release instead
RUSTY_VERSION=master
curl -L -o rusty-engine.tar.gz "https://github.com/opencv/opencv/archive/${RUSTY_VERSION}.tar.gz"
mkdir -p build
tar xf rusty-engine.tar.gz -C build/
rm rusty-engine.tar.gz

RE_DIR="build/rusty-engine-${RUSTY_VERSION}"

cd ${RE_DIR}
cargo build --release
cargo deb

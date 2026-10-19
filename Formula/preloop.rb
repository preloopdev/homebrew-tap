class Preloop < Formula
  desc "Preloop CI command-line interface"
  homepage "https://github.com/preloopdev/preloop"
  version "0.35.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.35.0/preloop-cli-aarch64-apple-darwin.tar.gz"
      sha256 "73a406f65cdb2c8398769a98a915a297e1fa703d42df4812e37ae888ab9438fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.35.0/preloop-cli-x86_64-apple-darwin.tar.gz"
      sha256 "04500ebcc8b1eaa9f3a00e437e814919c5ca53ea416770e27edd83cdcdf10cec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.35.0/preloop-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "40404c3c1d18b3d8b53578602ab1e9faf33402814ce6c0f64e1a8d98e414b5b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.35.0/preloop-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "60d656fc11ed5b0cede7994b170eca6f4a78b9aaddeb1e07166f437d294a30a2"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "preloop"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "preloop"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "preloop"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "preloop"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

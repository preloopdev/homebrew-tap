class Preloop < Formula
  desc "Preloop CI command-line interface"
  homepage "https://github.com/preloopdev/preloop"
  version "0.33.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.7/preloop-cli-aarch64-apple-darwin.tar.gz"
      sha256 "de69831cb41d4e8001468689f0a8f5c3ff8b77a09f7338647df65d1778b22be0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.7/preloop-cli-x86_64-apple-darwin.tar.gz"
      sha256 "9ea73197a9225e8e9d720d8b900cdab7dc6f6303c5c3dd39ae00818e2abca5ca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.7/preloop-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0cd5390aa80a8fda1b3cf26fc67e2e8c2e6fd752ea198f543e9583aea1ee4d7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.7/preloop-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb2e99f32415edb7e05994c3056e5933e1ff257613f34d6fcba57aabdf19d487"
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

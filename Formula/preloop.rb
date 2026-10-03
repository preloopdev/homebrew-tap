class Preloop < Formula
  desc "Preloop CI command-line interface"
  homepage "https://github.com/preloopdev/preloop"
  version "0.33.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.9/preloop-cli-aarch64-apple-darwin.tar.gz"
      sha256 "928b51d4325ea07053986ddc0b1cf1ccf614c54eca55ac5deabb8c33e5923224"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.9/preloop-cli-x86_64-apple-darwin.tar.gz"
      sha256 "7f95f6a3f2e0fd6fd0c612f24821c26c4b3c2c031a90757554c8f9ae95bca745"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.9/preloop-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "61e4d3f6dae954cff04b0f94ddb68f105a219ef291e415b38905da5ca43dc65a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.9/preloop-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e2b64c8270b98b2b9ffebc6f1cd512548cb359c594ae2a86b4ace8decf8d9ae5"
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

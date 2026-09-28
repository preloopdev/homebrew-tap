class Preloop < Formula
  desc "Preloop CI command-line interface"
  homepage "https://github.com/preloopdev/preloop"
  version "0.33.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.6/preloop-cli-aarch64-apple-darwin.tar.gz"
      sha256 "2bb1c0d614eee9aa65dd3c7ba319e4c5b012b8c8cab38bf68683b18478c08843"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.6/preloop-cli-x86_64-apple-darwin.tar.gz"
      sha256 "a1e80ccb6d97b5cbc876b46e753107616cfb9ad873b8a9076aa3035b7672281a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.6/preloop-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c5eefc8ba32ce7a89c79cdce520ec559f8961b9dab14cc5e139b874721297237"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.33.6/preloop-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2dde563f100c4fa90aebffd2d885036bb3a2e108551cbe644695e266772fb618"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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

class Preloop < Formula
  desc "Preloop CI command-line interface"
  homepage "https://github.com/preloopdev/preloop"
  version "0.34.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.34.0/preloop-cli-aarch64-apple-darwin.tar.gz"
      sha256 "6e4722138ff37ca9690018723f2f1caa80811c4d2182755f10020d5cbb2e2159"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.34.0/preloop-cli-x86_64-apple-darwin.tar.gz"
      sha256 "90385d695241d4e9f9ce4b528b247430cd681881dbd29a456a04e7db77502322"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/preloopdev/preloop/releases/download/v0.34.0/preloop-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "543bab7b413ec5b6bf663176bc437f6229b456eba01ce4ee76de559b55c65355"
    end
    if Hardware::CPU.intel?
      url "https://github.com/preloopdev/preloop/releases/download/v0.34.0/preloop-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49c953415a283094bf043c9d4659ed69111c9b22e746eab89d373a615a048952"
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

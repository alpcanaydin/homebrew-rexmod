class Rexmod < Formula
  desc "Turn Rex into a harness for your coding agent"
  homepage "https://github.com/alpcanaydin/rexmod"
  url "https://github.com/alpcanaydin/rexmod/releases/download/v0.1.13/rexmod-v0.1.13-darwin-arm64.tar.gz"
  sha256 "10de9964bb13d01414290a1d1de2d9229e96df2c26d315a89f89198925f1551d"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on "fzf"
  depends_on macos: :sequoia
  depends_on "neovim"
  depends_on "node" # language servers installed with npm

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"dist/rexmod"
    (bin/"rexmod-setup").write <<~SH
      #!/bin/sh
      # Patches Rex, hooks your agents and sets up the editor (see rexmod's README).
      exec "#{libexec}/install.sh" "$@"
    SH
    chmod 0755, bin/"rexmod-setup"
  end

  def caveats
    <<~EOS
      Finish the setup: it patches Rex, hooks your coding agents and sets up the editor.
        rexmod-setup
      Then quit Rex (⌘Q) and open it again. Run rexmod-setup again after upgrading.

      Remove everything (restores the official Rex):
        "$HOME/Library/Application Support/rexmod/scripts/uninstall.sh"
    EOS
  end

  test do
    assert_match "rexmod", shell_output("#{bin}/rexmod --help")
  end
end

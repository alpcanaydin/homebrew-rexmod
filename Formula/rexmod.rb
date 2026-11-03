class Rexmod < Formula
  desc "Turn Rex into a harness for your coding agent"
  homepage "https://github.com/alpcanaydin/rexmod"
  url "https://github.com/alpcanaydin/rexmod/releases/download/v0.1.17/rexmod-v0.1.17-darwin-arm64.tar.gz"
  sha256 "3461f0176c77853060f9d2d21afa462fdfa9aedb2c245a22ed516dbc07075872"
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

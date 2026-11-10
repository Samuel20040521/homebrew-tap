class AwTimer < Formula
  desc "Rize-style focus timer for the macOS menu bar, built on ActivityWatch"
  homepage "https://github.com/Samuel20040521/aw-timer"
  url "https://github.com/Samuel20040521/aw-timer/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "a3d14d15ca7ddc471370ce2ec7919aea87d4a13fa0127ad440e74f1717d6cda2"
  license "MIT"
  head "https://github.com/Samuel20040521/aw-timer.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
    # Re-sign so the Info.plist embedded in the binary is bound to the
    # signature; macOS needs it to ask for Calendar access.
    system "codesign", "--force", "--sign", "-", bin/"aw-timer"
    pkgshare.install "default_config.toml"
  end

  service do
    run [opt_bin/"aw-timer", "run"]
    keep_alive successful_exit: false
    process_type :interactive
    log_path var/"log/aw-timer.log"
    error_log_path var/"log/aw-timer.log"
  end

  def caveats
    <<~EOS
      aw-timer reads its data from ActivityWatch, which must be running:
        brew install --cask activitywatch
        open -a ActivityWatch

      Start aw-timer now and at every login:
        brew services start aw-timer

      If you previously used install.sh, run its uninstall.sh first so
      two copies don't run at once.

      Clicking a notification opens the report window only in the
      install.sh version (an app bundle); here it opens Script Editor.

      Optional config: copy the documented default and edit it.
        mkdir -p ~/.config/aw-timer
        cp #{opt_pkgshare}/default_config.toml ~/.config/aw-timer/config.toml
    EOS
  end

  test do
    assert_match "aw-timer", shell_output("#{bin}/aw-timer --help")
  end
end

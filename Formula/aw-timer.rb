class AwTimer < Formula
  desc "Rize-style focus timer for the macOS menu bar, built on ActivityWatch"
  homepage "https://github.com/Samuel20040521/aw-timer"
  url "https://github.com/Samuel20040521/aw-timer/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "11f83c52ea4b80149f3cb725375f4d7740948033fff5bcd37e12db3e50a0ed62"
  license "MIT"
  head "https://github.com/Samuel20040521/aw-timer.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
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

      Optional config: copy the documented default and edit it.
        mkdir -p ~/.config/aw-timer
        cp #{opt_pkgshare}/default_config.toml ~/.config/aw-timer/config.toml
    EOS
  end

  test do
    assert_match "aw-timer", shell_output("#{bin}/aw-timer --help")
  end
end

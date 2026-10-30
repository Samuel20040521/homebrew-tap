# Samuel20040521/homebrew-tap

Homebrew formulae for [aw-timer](https://github.com/Samuel20040521/aw-timer), a Rize-style focus timer for the macOS menu bar.

```bash
brew tap samuel20040521/tap && brew trust samuel20040521/tap
```

```bash
brew install aw-timer
```

```bash
brew services start aw-timer
```

aw-timer needs [ActivityWatch](https://activitywatch.net/) running (`brew install --cask activitywatch`).
The formula builds from source, so Homebrew installs Rust as a build dependency on first install.

Homebrew 7 refuses to load formulae from third-party taps until you trust them, hence `brew trust`.

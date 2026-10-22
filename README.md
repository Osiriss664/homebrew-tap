# Osiriss664 Homebrew tap

Homebrew formula and cask for [SandSeek](https://github.com/Osiriss664/SandSeek).

```sh
brew install osiriss664/tap/sandseek          # the command line tool, built from source
brew install --cask osiriss664/tap/sandseek   # the app
```

Both need an Apple silicon Mac with macOS 26, Apple's `container` tool from
Apple's signed installer (https://github.com/apple/container/releases) and a
local model server (TUFF, llama.cpp or Ollama). SandSeek never downloads a
model.

The app is signed ad hoc and not notarized, so macOS asks before the first
start (System Settings > Privacy & Security > Open Anyway).

Security reports: see SandSeek's
[SECURITY.md](https://github.com/Osiriss664/SandSeek/blob/main/SECURITY.md).

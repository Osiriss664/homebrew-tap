cask "sandseek" do
  version "0.4.1"
  sha256 "163e6a2d21a7ee6f2f1456be697ce67d9fe74ac71694f9b0d91342c615a6d96e"

  url "https://github.com/Osiriss664/SandSeek/releases/download/v#{version}/SandSeek-#{version}.zip"
  name "SandSeek"
  desc "Let a local LLM research the web from inside a throwaway Apple container VM"
  homepage "https://github.com/Osiriss664/SandSeek"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "SandSeek.app"

  zap trash: [
    "~/Library/Application Support/SandSeek",
    "~/Library/Preferences/io.github.osiriss664.sandseek.plist",
  ]

  caveats <<~EOS
    SandSeek is signed ad hoc and not notarized. macOS blocks the first start:
    open System Settings > Privacy & Security and choose "Open Anyway".

    It also needs Apple's `container` tool from Apple's signed installer
    (https://github.com/apple/container/releases) and a local model server
    (TUFF, llama.cpp or Ollama). SandSeek never downloads a model.
  EOS
end

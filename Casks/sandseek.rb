cask "sandseek" do
  version "0.4.3"
  sha256 "1109c6ff79877ca127936c6335b75c06b7fcb64ecd559566f2e9233f9e0a2de4"

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

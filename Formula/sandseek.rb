class Sandseek < Formula
  desc "Let a local LLM research the web from inside a throwaway Apple container VM"
  homepage "https://github.com/Osiriss664/SandSeek"
  url "https://github.com/Osiriss664/SandSeek/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "ec9f0bb1563d65f4da105eeb264b331af9c6ac17a16c2763292c9a4d18a88b4a"
  license "Apache-2.0"
  head "https://github.com/Osiriss664/SandSeek.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "sandseek"
    bin.install ".build/release/sandseek"

    # The sandbox script builds its image from ../Sandbox, so keep the
    # checkout layout: share/sandseek/Scripts next to share/sandseek/Sandbox.
    (pkgshare/"Scripts").install "Scripts/research_sandbox.sh"
    pkgshare.install "Sandbox"
    (bin/"sandseek-sandbox").write <<~SH
      #!/bin/bash
      exec "#{pkgshare}/Scripts/research_sandbox.sh" "$@"
    SH
  end

  def caveats
    <<~EOS
      SandSeek needs two things Homebrew does not install:

      1. Apple's `container` tool, from Apple's signed installer at
         https://github.com/apple/container/releases
         SandSeek runs only the copy at /usr/local/bin/container and checks
         Apple's signature, so Homebrew's own `container` formula is not used.
      2. A local model server on 127.0.0.1: TUFF, llama.cpp (llama-server)
         or Ollama. SandSeek never downloads a model.

      Start the web sandbox with:
        sandseek-sandbox start
      Then ask a question:
        sandseek "your question" --model <name>
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sandseek --version")
    assert_match "--check-exposure", shell_output("#{bin}/sandseek --help")
    assert_path_exists pkgshare/"Sandbox/Containerfile"
  end
end

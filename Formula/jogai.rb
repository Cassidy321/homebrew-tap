# typed: false
# frozen_string_literal: true

class Jogai < Formula
  desc "AI session recaps — jog your memory"
  homepage "https://github.com/Cassidy321/jogai"
  url "https://github.com/Cassidy321/jogai/archive/refs/tags/v1.1.0.tar.gz"
  version "1.1.0"
  sha256 "43962a7c0898203e920db6b1ea2f3046701756c84a2922b1ae779a77a01d1d75"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/Cassidy321/jogai/internal/cli.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"jogai"), "./cmd/jogai"
  end

  def caveats
    <<~EOS
      jogai sets up a daily launchd job and registers itself in Claude Code.
      Remove both before uninstalling:
        jogai uninstall          # add --data to also delete the session archive
        brew uninstall jogai
    EOS
  end

  test do
    assert_match "jogai #{version}", shell_output("#{bin}/jogai version")
  end
end

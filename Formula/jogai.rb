# typed: false
# frozen_string_literal: true

class Jogai < Formula
  desc "AI session recaps — jog your memory"
  homepage "https://github.com/Cassidy321/jogai"
  url "https://github.com/Cassidy321/jogai/archive/refs/tags/v1.0.2.tar.gz"
  version "1.0.2"
  sha256 "6b02cf479ac0c49aa7780bfc17c200d9c04c33fe99406f6d37bd351717385444"
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

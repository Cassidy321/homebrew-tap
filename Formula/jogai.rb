# typed: false
# frozen_string_literal: true

class Jogai < Formula
  desc "AI session recaps — jog your memory"
  homepage "https://github.com/Cassidy321/jogai"
  url "https://github.com/Cassidy321/jogai/archive/refs/tags/v1.1.1.tar.gz"
  version "1.1.1"
  sha256 "4e010d550213ae49a7b5a13a81950c1b65b13bb4364dd3a0f07db715b77b6249"
  license "MIT"

  bottle do
    root_url "https://github.com/Cassidy321/jogai/releases/download/v1.1.1"
    sha256                               arm64_sequoia: "5cd5cf6b5e7256d39bd57d3d19cf562f2ef3e6640d15a8a6c0e912f2abcd51fa"
    sha256 cellar: :any_skip_relocation, sequoia:       "fc3edbfae3983a520b10c80eadfe0d67a9f938a94974b91840f4058dfb7a5f1c"
  end

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

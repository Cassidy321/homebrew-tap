# typed: false
# frozen_string_literal: true

class Jogai < Formula
  desc "AI session recaps — jog your memory"
  homepage "https://github.com/Cassidy321/jogai"
  url "https://github.com/Cassidy321/jogai/archive/refs/tags/v1.1.2.tar.gz"
  version "1.1.2"
  sha256 "f31d7d17ef6ef939ef01a8157bb6d61c5a155fa6e4fb6fbc6028ff34d0b56bc4"
  license "MIT"

  bottle do
    root_url "https://github.com/Cassidy321/jogai/releases/download/v1.1.2"
    sha256                               arm64_sequoia: "f11dc58769157ead2a6d3bffa307c11a42f2f892b60c7d2ec32cb7fa31451e59"
    sha256 cellar: :any_skip_relocation, sequoia:       "65b63c8d2425be2b366cfdfe4a9abc0e309f10730b348d32ac5aceae6274454c"
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

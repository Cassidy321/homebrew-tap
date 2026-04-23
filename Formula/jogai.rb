# typed: false
# frozen_string_literal: true

class Jogai < Formula
  desc "AI session recaps — jog your memory"
  homepage "https://github.com/Cassidy321/jogai"
  url "https://github.com/Cassidy321/jogai/archive/refs/tags/v0.5.1.tar.gz"
  version "0.5.1"
  sha256 "fa00d29e6bb2f9e0d162d3c2b1d106bc8642462ffde806ce8aa192b888083790"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/Cassidy321/jogai/internal/cli.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"jogai"), "./cmd/jogai"
  end

  test do
    assert_match "jogai #{version}", shell_output("#{bin}/jogai version")
  end
end

# typed: false
# frozen_string_literal: true

class Jogai < Formula
  desc "AI session recaps — jog your memory"
  homepage "https://github.com/Cassidy321/jogai"
  url "https://github.com/Cassidy321/jogai/archive/refs/tags/v0.4.0.tar.gz"
  version "0.4.0"
  sha256 "9b5b41da96cfd2ff7631ef8e22b4e11403b8d1d14faba4bffac1984dcb1e0fd6"
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

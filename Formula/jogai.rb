# typed: false
# frozen_string_literal: true

class Jogai < Formula
  desc "AI session recaps — jog your memory"
  homepage "https://github.com/Cassidy321/jogai"
  url "https://github.com/Cassidy321/jogai/archive/refs/tags/v0.5.0.tar.gz"
  version "0.5.0"
  sha256 "e199f16f0fde72856c9ec18172f3c09f891a3565207f4928f2356f72f740c8c7"
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

# typed: false
# frozen_string_literal: true

class Jogai < Formula
  desc "AI session recaps — jog your memory"
  homepage "https://github.com/Cassidy321/jogai"
  url "https://github.com/Cassidy321/jogai/archive/refs/tags/v0.6.0.tar.gz"
  version "0.6.0"
  sha256 "a1153fc10aacf23ae41a36394a29ecd86a70656dec9bb9168603ac954b7b9aa7"
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

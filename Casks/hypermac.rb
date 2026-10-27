cask "hypermac" do
  version "0.8.0,preview-0.8.0-8538581"
  sha256 "d31758d467615fe34f4879bc6459600cac2b313fef8953cfb8387072f74974a6"

  url "https://github.com/c0dewars/HyperMac/releases/download/#{version.csv.second}/HyperMac-#{version.csv.first}-apple-silicon-preview.dmg"
  name "HyperMac"
  desc "Tiling window manager with saved layouts and keyboard shortcuts"
  homepage "https://github.com/c0dewars/HyperMac"

  livecheck do
    url "https://github.com/c0dewars/HyperMac.git"
    regex(/^preview[._-](\d+(?:\.\d+)+)[._-](\h+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map do |tag|
        match = tag.match(regex)
        next if match.blank?

        "#{match[1]},#{tag}"
      end
    end
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "HyperMac.app"

  uninstall quit: "local.hypermac.app"

  zap trash: "~/.config/hypermac"

  caveats <<~EOS
    HyperMac is an ad-hoc signed development preview and is not notarized by Apple.
    If macOS says it cannot verify the developer, open HyperMac once, then use
      System Settings → Privacy & Security → Open Anyway
    HyperMac needs Accessibility permission to move windows:
      System Settings → Privacy & Security → Accessibility
    After an upgrade you may need to remove and re-add HyperMac there.
  EOS
end

cask "devsweep" do
  version "1.2.0"
  sha256 "bbf5c1b5dc1fc5c5bd544b76e422350d709a311aa582486457a5d87e9cd25089"

  url "https://github.com/moovendhan-v/devsweep/releases/download/v#{version}/DevSweep-#{version}.zip"
  name "DevSweep"
  desc "Clean developer caches, system junk, large files and unused apps"
  homepage "https://github.com/moovendhan-v/devsweep"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "DevSweep.app"

  # DevSweep is ad-hoc signed, not notarized: clear the download quarantine so macOS opens it.
  # Remove this block once releases are signed with a Developer ID and notarized.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/DevSweep.app"], must_succeed: false
  end

  uninstall quit: "com.teamnova.DevSweep"

  zap trash: [
    "~/Library/Caches/com.teamnova.DevSweep",
    "~/Library/HTTPStorages/com.teamnova.DevSweep",
    "~/Library/Preferences/com.teamnova.DevSweep.plist",
    "~/Library/Saved Application State/com.teamnova.DevSweep.savedState",
  ]
end

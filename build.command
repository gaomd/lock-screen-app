cd "$(dirname "$0")"

mkdir -p dist
rm -rf "dist/Lock Screen.app"

# Compile AppleScript to macOS App
osacompile -o "dist/Lock Screen.app" "Lock Screen.applescript"

# Install the icon
cp "Lock Screen.icns" "dist/Lock Screen.app/Contents/Resources/applet.icns"

# Set a version number
# https://apple.stackexchange.com/a/173473/14896
# https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
plutil -insert CFBundleShortVersionString -string 0.0.1 "dist/Lock Screen.app/Contents/Info.plist"
plutil -insert CFBundleVersion -string 0.0.1 "dist/Lock Screen.app/Contents/Info.plist"

# Force the icon cache to be updated
touch "dist/Lock Screen.app/Contents/Resources/applet.icns"

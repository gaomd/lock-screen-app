cd "$(dirname "$0")"

mkdir -p dist
rm -rf "dist/Lock Screen.app"

# Compile AppleScript to macOS App
osacompile -o "dist/Lock Screen.app" "Lock Screen.applescript"

# Install the icon
cp "Lock Screen.icns" "dist/Lock Screen.app/Contents/Resources/applet.icns"

# Force the icon cache to be updated
touch "dist/Lock Screen.app/Contents/Resources/applet.icns"

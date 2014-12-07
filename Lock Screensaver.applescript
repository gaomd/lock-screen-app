-- Based on http://apple.stackexchange.com/questions/51443/disable-screensaver-password-requirement-from-command-line
tell application "System Events" to set require password to wake of security preferences to true
delay 0.25
do shell script "/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
tell application "System Events" to set require password to wake of security preferences to false
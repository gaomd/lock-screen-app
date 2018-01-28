activate application "SystemUIServer"
tell application "System Events"
    tell process "SystemUIServer" to keystroke "q" using {command down, control down}
end tell

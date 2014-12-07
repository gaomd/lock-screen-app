activate application "SystemUIServer"
tell application "System Events"
	tell process "SystemUIServer"
		set mbar to menu bar 1
		set n to number of menu bar items of mbar
		repeat with i from 1 to n
			tell menu bar item i of mbar
				click
				try
					if name of menu item 1 of front menu is "Lock Screen" then
						click menu item "Lock Screen" of front menu
						exit repeat
					end if
				end try
			end tell
		end repeat
	end tell
end tell
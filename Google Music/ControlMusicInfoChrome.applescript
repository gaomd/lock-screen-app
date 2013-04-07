-- Get path to my current location...
tell application "Finder"
	set p to path to me
	set pathName to POSIX path of (parent of p as text)
	set appicon to pathName & "ControlMusic.icns"
end tell

tell application "System Events"
	set isRunning to Â
		(count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp")) > 0
end tell

if isRunning then
	tell application id "com.Growl.GrowlHelperApp"
		-- Make a list of all the notification types 
		-- that this script will ever send:
		set the allNotificationsList to Â
			{"Song Info", "Action Taken"}
		
		-- Make a list of the notifications 
		-- that will be enabled by default.      
		-- Those not enabled by default can be enabled later 
		-- in the 'Applications' tab of the Growl preferences.
		set the enabledNotificationsList to Â
			{"Song Info"}
		
		-- Register our script with growl.
		-- You can optionally (as here) set a default icon 
		-- for this script's notifications.
		register as application Â
			"Control Music Scripts" all notifications allNotificationsList Â
			default notifications enabledNotificationsList Â
			icon of application "Google Chrome"
	end tell
end if

if isRunning then
	tell application "Google Chrome"
		repeat with currWindow in (every window)
			repeat with currTab in (every tab of currWindow)
				set theURL to (URL of currTab) as string
				if "play.google.com/music" is in theURL then
					set foundTab to currTab
				end if
			end repeat
		end repeat
		-- get song info from browser :)
		tell foundTab
			set |title| to execute javascript "document.getElementById('playerSongTitle').innerText"
			set artist to execute javascript "document.getElementById('playerArtist').innerText"
			set art to "http:" & (execute javascript "document.getElementById('playingAlbumArt').getAttribute('src')")
		end tell
	end tell
	
	--Download album-art
	try
		do shell script "cd " & (quoted form of pathName) & ";curl -f -O -J " & art & " > out.txt"
	end try
	set artfile to do shell script "cat " & (quoted form of pathName & "out.txt") & " | perl -pe 's|.*\\b(\\w+\\.\\w+).|$1|g'"
	tell application "Finder"
		set artalias to (parent of p as text) & artfile as alias
	end tell
	
	-- show song info on growl!!
	tell application id "com.Growl.GrowlHelperApp"
		try
			notify with name Â
				"Song Info" title Â
				(|title|) as text description Â
				(artist) as text application name Â
				"Control Music Scripts" image from location artalias
		on error
			notify with name Â
				"Song Info" title Â
				(|title|) as text description Â
				(artist) as text application name Â
				"Control Music Scripts"
		end try
	end tell
	try
		do shell script "rm " & (quoted form of pathName & artfile)
	on error
		do shell script "cd " & (quoted form of pathName) & "; rm *.png *.jpg"
	end try
end if

-- Get path to my current location...
tell application "Finder"
	set p to path to me
	set pathName to POSIX path of (parent of p as text)
	set appicon to pathName & "ControlMusic.icns"
end tell

tell application "System Events"
	try
		set gnCommand to do shell script "ls /usr/local/bin/growlnotify"
		set isRunning to true
	on error
		set isRunning to false
		display dialog "Please install growlnotify"
	end try
end tell

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
			set artist to execute javascript "document.querySelector('.player-artist-album-wrapper').innerText"
			set art to "http:" & (execute javascript "document.getElementById('playingAlbumArt').getAttribute('src')")
		end tell
	end tell
	
	--Download album-art
	try
		do shell script "cd " & (quoted form of pathName) & ";curl -f -O -J " & art & " > out.txt"
	end try
	set artfile to do shell script "cat " & (quoted form of pathName & "out.txt") & " | perl -pe 's|.*\\b(\\w+\\.\\w+).|$1|g'"
	set artpath to do shell script "ls " & (quoted form of pathName) & "*.??g"
	
	-- show song info on growl!!
	set shellCommand to gnCommand & " -n ControlMusic.app -a ControlMusic.app -N 'Music Info' --image " & (quoted form of artpath) & " -p1 -m \"" & ((artist) as text) & "\" " & (quoted form of (title) as text)
	log shellCommand
	do shell script shellCommand
	try
		do shell script "rm " & (quoted form of artpath)
	on error
		do shell script "cd " & (quoted form of pathName) & "; rm *.png *.jpg"
	end try
end if

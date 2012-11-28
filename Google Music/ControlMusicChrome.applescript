property actions : {{|name|:"ControlMusicPlay", action:"playPause"}, {|name|:"ControlMusicNext", action:"nextSong"}, {|name|:"ControlMusicPrev", action:"prevSong"}}

on getAction for aName
	repeat with action in actions
		if aName is equal to (|name| of action) then return action of action
	end repeat
	return missing value
end getAction

tell application "Finder"
	set p to path to me
	set pathName to quoted form of POSIX path of (parent of p as text)
	set fileName to name of file p as text
	set AppleScript's text item delimiters to "."
	set theArray to every text item of fileName
	set myName to item 1 of theArray
	set myExtension to "." & item 2 of theArray
end tell

set action to getAction for myName

tell application "Google Chrome"
	set allTabs to (every tab of every window)
	set allTabs to item 1 of allTabs --don't ask me why but otherwise it didn't work. Maybe it's a problem with a extension for me
	repeat with currTab in allTabs
		set theURL to (URL of currTab) as string
		if "play.google.com/music" is in theURL then
			exit repeat
		end if
	end repeat
	
	if action is not missing value then
		tell currTab to execute javascript "SJBpost('" & action & "');"
	end if
end tell

if action is missing value then
	set msg to "Script failed to run due to missing 'action'. The action is defined by the filename of the script." & return & "Valid 'filename: action' values are:" & return & return
	repeat with action in actions
		set msg to msg & "	" & (|name| of action) & ": " & (action of action) & return
	end repeat
	set msg to msg & return & "This script can make some copies if you want to."
	set returnValue to display dialog msg buttons {"Create files", "I'll do it myself"}
	if returnValue is equal to {button returned:"Create files"} then
		--create the files…
		display alert "Here we go: " & pathName
		set myFullName to pathName & myName & myExtension
		repeat with action in actions
			do shell script "cp -R " & myFullName & " " & pathName & (|name| of action) & myExtension
		end repeat
		
	end if
end if
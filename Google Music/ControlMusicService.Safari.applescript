--------------------------------------------------------------------------------------
-- ControlMusicService applescript, for use in Automator:
-- In Automator, create new 'service', pick 'Run Applescript' action
-- and replace the contents of that script with the contents of this
-- file.
-- 
-- Make sure you set the Google Music 'action' you want to run on the 
-- first line of code, after this comments block.
-- Known actions that will work:
--    playPause
--    nextSong
--    prevSong
-- 
-- Known browser to work with this script are:
--    Safari
-- 
-- Based on code provided at 
-- http://hints.macworld.com/article.php?story=20110622061755509
--------------------------------------------------------------------------------------
set sAction to "playPause"

tell application "Safari"
	set allTabs to (every tab of every window)
	set allTabs to item 1 of allTabs --magic bullet
	repeat with currTab in allTabs
		set theURL to (URL of currTab) as string
		if "play.google.com/music" is in theURL then
			exit repeat
		end if
	end repeat
	if sAction is not missing value then
		tell currTab to do JavaScript "SJBpost('" & sAction & "');"
		return true
	end if
end tell
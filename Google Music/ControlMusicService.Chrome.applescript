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
--    Chrome
--
-- Based on code provided at
-- http://hints.macworld.com/article.php?story=20110622061755509
--------------------------------------------------------------------------------------
set sAction to "playPause"

tell application "Google Chrome"
	set foundTab to missing value
	repeat with currWindow in (every window)
		repeat with currTab in (every tab of currWindow)
			set theURL to (URL of currTab) as string
			if "play.google.com/music" is in theURL then
				set foundTab to currTab
			end if
		end repeat
	end repeat
	
	if foundTab is not missing value then
		tell foundTab to execute javascript "SJBpost('" & sAction & "');"
	end if
end tell

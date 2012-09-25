property __WinLib : null

to init()
	set myPath to (path to me)
	tell application "Finder" to set myFolder to (folder of myPath) as text
	set __WinLib to load script alias (myFolder & "window.scpt")
	
	init() of __WinLib
	
end init

init()
moveUp() of __WinLib
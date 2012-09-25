property __Monitors : null
property __App : null
property __Bounds : null
property __Window : null
property __MonLib : null

property __Locations : {}

set myPath to (path to me)
tell application "Finder" to set myFolder to (folder of myPath) as text
set __MonLib to load script alias (myFolder & "monitors.scpt")

init() of __MonLib
set __Monitors to getMonitors() of __MonLib

to getWindowPosition()
	tell application __App
		tell front window
			set {l, t, r, b} to (get bounds)
			set uid to id
		end tell
	end tell
	return {l, t, r, b, uid}
end getWindowPosition

to calculateWindow(_bounds)
	set {l, t, r, b} to _bounds
	set w to (r - l)
	set h to (b - t)
	return {w, h, l, t, r, b}
end calculateWindow

to getMonitorForWindowPosition(_window)
	set {w, h, l, t, r, b} to _window
	set {dl, dt, dr, db} to getDesktop() of __MonLib
	-- First matching against left top
	repeat with i from 1 to count __Monitors
		set mon to item i of __Monitors
		set {mw, mh, ml, mt, mr, mb, main} to mon
		
		log "Finding out if window is on this mon"
		log mon
		log _window
		
		if l < dl then
			--If left is less than desktop check if right is on mon
			log "Checking right is on mon"
			set horizontal to true is equal to (r ³ ml and r ² mr)
		else
			--else check if left is on mon
			log "Checking left is on mon"
			set horizontal to true is equal to (l ³ ml and l ² mr)
		end if
		
		log horizontal
		
		if t < dt then
			--If top is less than desktop check if bottom is on mon
			log "Checking bottom is on mon"
			set vertical to true is equal to (b ³ mt and b ² mb)
		else
			--else check if top is on mon
			log "Checking top is on mon"
			set vertical to true is equal to (t ³ mt and t ² mb)
		end if
		
		log vertical
		
		if horizontal and vertical then return mon
	end repeat
end getMonitorForWindowPosition

to getOtherMonitor(_current)
	repeat with i from 1 to count __Monitors
		set mon to item i of __Monitors
		if (item 3 of _current) is not equal to (item 3 of mon) then return mon
	end repeat
end getOtherMonitor

to setBounds(_bounds)
	tell application __App
		tell front window
			set bounds to _bounds
		end tell
	end tell
end setBounds

to getLeftBounds(_monitor)
	set {mw, mh, ml, mt, mr, mb, mm} to _monitor
	
	set l to ml
	set t to mt
	set r to l + (mw / 2)
	set b to mb
	return {l, t, r, b}
end getLeftBounds

to getRightBounds(_monitor)
	set {mw, mh, ml, mt, mr, mb, mm} to _monitor
	
	set r to mr
	set t to mt
	set l to (r - (mw / 2) + 1)
	set b to mb
	return {l, t, r, b}
end getRightBounds

to getMaxBounds(_monitor)
	set {mw, mh, ml, mt, mr, mb, mm} to _monitor
	
	set l to ml
	set t to mt
	set r to mr
	set b to mb
	return {l, t, r, b}
end getMaxBounds

to getMiddleBounds(_monitor)
	set {mw, mh, ml, mt, mr, mb, mm} to _monitor
	set mow to mw / 8
	set moh to mh / 8
	
	set l to ml + mow
	set t to mt + moh
	set r to mr - mow
	set b to mb - moh
	return {l, t, r, b}
end getMiddleBounds

to moveLeft()
	set win to __Window
	set current to getMonitorForWindowPosition(win)
	
	if isRight(win, current) then
		log "Should restore this window"
		restoreWindow(current)
	else
		
		if not isLeft(win, current) then
			log "Should preserve this window"
			storeLocation(__Bounds)
		end if
		
		set {w, h, l, t, r, b} to win
		
		try
			if isLeft(win, current) then
				set current to getOtherMonitor(current)
				set _bounds to getRightBounds(current)
			else
				set _bounds to getLeftBounds(current)
			end if
			
			if l is greater than (item 1 of (getDesktop() of __MonLib)) then
				setBounds(_bounds)
			end if
		end try
		
	end if
end moveLeft

to moveRight()
	set win to __Window
	set current to getMonitorForWindowPosition(win)
	
	if isLeft(win, current) then
		log "Should restore this window"
		restoreWindow(current)
	else
		
		if not isRight(win, current) then
			log "Should preserve this window"
			storeLocation(__Bounds)
		end if
		
		set {w, h, l, t, r, b} to win
		
		try
			if isRight(win, current) then
				set current to getOtherMonitor(current)
				set _bounds to getLeftBounds(current)
			else
				set _bounds to getRightBounds(current)
			end if
			
			if r is less than (item 3 of (getDesktop() of __MonLib)) then
				setBounds(_bounds)
			end if
		end try
		
	end if
end moveRight

to restoreWindow(_monitor)
	try
		set {l, t, r, b} to getLocation(__Bounds)
		setBounds({l, t, r, b})
		removeLocation(__Bounds)
	on error
		setBounds(getMiddleBounds(_monitor))
	end try
end restoreWindow

to moveUp()
	
	tell application __App
		tell front window
			set zoomed to true
		end tell
	end tell
	
end moveUp

to moveDown()
	
	tell application __App
		tell front window
			if zoomed then
				set zoomed to false
			else
				set collapsed to true
			end if
		end tell
	end tell
	
end moveDown

to matchBounds(_window, _bounds)
	set {ll, lt, lr, lb} to _bounds
	set {w, h, l, t, r, b} to _window
	set total to (mathAbs(ll - l) + mathAbs(lt - t) + mathAbs(lr - r) + mathAbs(lb - b))
	
	log _bounds
	log _window
	log total
	
	return total ² 50
end matchBounds

to isLeft(_window, _monitor)
	return matchBounds(_window, getLeftBounds(_monitor))
end isLeft

to isRight(_window, _monitor)
	return matchBounds(_window, getRightBounds(_monitor))
end isRight

to storeLocation(_bounds)
	try
		set loc to getLocation(_bounds)
	on error
		set loc to {(last item of _bounds), _bounds}
		set end of __Locations to loc
	end try
end storeLocation

to getLocation(_bounds)
	set uid to last item of _bounds
	repeat with i from 1 to count __Locations
		set loc to item i of __Locations
		set {oid, bounds} to loc
		if uid is equal to oid then return loc
	end repeat
end getLocation

to removeLocation(_bounds)
	set newList to {}
	set uid to last item of _bounds
	repeat with i from 1 to count __Locations
		set loc to item i of __Locations
		set {oid, bounds} to loc
		if uid is not equal to oid then set end of newList to loc
	end repeat
	set __Locations to newList
end removeLocation

to mathAbs(_num)
	if _num < 0 then return (_num * -1)
	return _num
end mathAbs

to init()
	set __App to name of (info for (path to frontmost application))
	set myPath to (path to me)
	tell application "Finder" to set myFolder to (folder of myPath) as text
	set __MonLib to load script alias (myFolder & "monitors.scpt")
	
	init() of __MonLib
	set __Monitors to getMonitors() of __MonLib
	
	set __Bounds to getWindowPosition()
	set __Window to calculateWindow(__Bounds)
end init

init()
moveLeft()
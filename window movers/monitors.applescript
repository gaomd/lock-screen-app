property __Monitors : {}
property __Desktop : null

to parseCsvEntry(csvEntry)
	set builtin to ""
	
	set AppleScript's text item delimiters to ","
	set {width, height, main} to csvEntry's text items
	if length of csvEntry's text items is 4 then set builtin to (item 4 of csvEntry's text items)
	set AppleScript's text item delimiters to {""}
	
	return {width, height, main, builtin}
end parseCsvEntry

to parseCSV(csvData)
	set csvEntries to paragraphs of csvData
	set csvList to {}
	
	repeat with i from 1 to count csvEntries
		set end of csvList to parseCsvEntry(csvEntries's item i)
	end repeat
	
	return csvList
end parseCSV

to getMonitors()
	return __Monitors
end getMonitors

to getDesktop()
	return __Desktop
end getDesktop


--------------------------------------
-- MAIN

to init()
	
	tell application "Finder" to set __Desktop to get bounds of window of desktop
	set __Monitors to {}
	
	--Getting the screen-sizes from system profiler and parsing it to CSV
	set csvData to (do shell script "system_profiler SPDisplaysDataType | egrep '(Built-In:)|(Main Display:)|([[:digit:]]+ x [[:digit:]])' | perl -pe 's|( +)(?:Bui\\|Mai)|\\1,|g' | perl -pe 's|\\n\\| x |,|g' | perl -pe 's|,\\s+Re|\\n|g' | perl -pe 's|\\s{2,}\\| @.+Hz\\|[\\w -]+: \\|,n||g' | perl -pe 's|,Yes,,Y|,Yes,Y|g'")
	
	--Using specialised parser to parse the screensizes.
	set monitors to parseCSV(csvData)
	
	log "Screen sizes found"
	log monitors
	
	repeat with i from 1 to count monitors
		set mon to item i of monitors
		set {w, h, main, builtin} to mon
		set main to (main is equal to "Yes")
		
		set l to 0
		set t to 0
		set r to (w - 0)
		set b to (h - 0)
		
		if not main then
			
			log "This is not main"
			
			--Horizontal position
			if item 1 of __Desktop is less than 0 then
				log "Calculate second screen against left"
				set l to item 1 of __Desktop
				set r to (l + (item 1 of mon))
			else
				log "Calculate second screen against right"
				set r to item 3 of __Desktop
				set l to (r - (item 1 of mon))
			end if
			
			--Vertical position
			if item 2 of __Desktop is less than 0 then
				log "Calculate second screen against top"
				set t to item 2 of __Desktop
				set b to (t + (item 2 of mon))
			else
				log "Calculate second screen against bottom"
				set b to item 4 of __Desktop
				set t to (b - (item 2 of mon))
			end if
			
		end if
		
		set end of __Monitors to {w, h, l, t, r, b, main}
		
	end repeat
	
	log "Screen locations"
	log __Monitors
	
end init

init()
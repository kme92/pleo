utility Ugobe "UGOBE Utilities"
(
    -- Ugobe Animation Export Script
    -- Authors: Tyler W. Wilson
    --
    -- This script will export an animation from a Ugobe-standard rig to 
    -- a CSV formatted file which then can be compiled by the Ugobe tool set.
    --
    -- History:
    -- 12/24/07 TWW Generailized from Pleo.ms, can export any Ugobe Life form
    --

    -- convert from Max time to frame, based on set frame rate
    function getFrame t =
    (
        if t == undefined then
            t = animationRange.end
        t = t - animationRange.start    
        (t as integer) * frameRate / 4800
    )

    -- convert from Max time to Ugobe time
    function getTime t =
    (
        if t == undefined then
            t = animationRange.end
        t = t - animationRange.start    
        (t as float) / 4800
    )
    
    -- main worker function. export current animation to CSV file
    function export_as_csv fs = 
    (
        -- print the prelude/header
        format "Header\n" to:fs
        format "rate=%\n" frameRate to:fs
        format "frames=%\n" (getFrame(undefined)) to:fs
        format "duration=%\n" (getTime(undefined)) to:fs
        format "type=degree\n" to:fs
        format "Body\n" to:fs
        format "Time,Frame" to:fs
        for s in servos do
        (
            if s.inRig() do
            (
                format ",%" (s.getName()) to:fs
            )
        )
        format "\n" to:fs
        
        lastsound = 0
        
        -- now loop through time and save out all the servo data        
        for tick = animationRange.start to animationRange.end do
        (
            at time tick
            (
                -- print frame and time values
                tyme = getTime tick
                frame = getFrame tick
                format "%,%" tyme frame to:fs
                
                -- now the servo angles
                for s in servos do
                (
                    value = s.getAngle()
                    
                    if s.name == "SD" then 
                    (
                        if lastsound != value then 
                        (
                            lastsound = value
                        ) else 
                        (
                            value = 0
                        )
                        
                        -- write out the desired sound file as a string in the csv
                        if value != 0 then
                        (
                            format ",%" soundTable[value] to:fs
                        )
                        else
                        (
                            format ",0.0" to:fs
                        )
                        
                    )
                    else 
                    (
                        format ",%" (value as float) to:fs
                    )
                )
            )
            format "\n" to:fs
        )
    )
    
    function export_as_umf fs =
    (
        -- TODO
    )
    
    function import_from_csv fs =
    (
        -- the header is an array of names, starting with "Time,Frame"
        header = undefined
        -- start with an empty node array. it will be filled in when we parse the header
        nodes = #()
        
        frames = 0

        -- loop through the whole file          
        while not eof fs do (

            -- read one line from the file
            line = readLine fs
            
            -- break it up into tokens
            tokens = filterString line ","

            -- look for the number of frames, so we can set the animationRange properly
            if tokens.count < 2 then (
                tokens2 = filterString line "="
                if tokens2.count == 2 then (
                    index = findString tokens2[1] "frames"
                    if index != undefined then (
                        frames = tokens2[2] as integer
                        format "frames: %\n" frames
                        animationRange = interval 0 frames
                    )
                )
            )
            
            -- if we get a line with fewer than two tokens, it is not of interest to us
            if tokens.count > 2 then (
                
                -- if the first token matches 'Time', then we know this is the first entry
                if tokens[1] == "Time" then (
                    
                    -- format "Got header\n"
                    
                    -- construct the servos array so it matches the order given in the header
                    header = tokens
                    
                    -- for each token, add the right servo instance
                    for token in tokens do (
                        apppend nodes getServoByName token
                    )

                    -- print nodes
                    
                    -- note the #noMap - this prints the whole array on one line
                    -- print header #noMap
                    
                ) else (
                
                    -- format "Got data point\n"
                    
                    -- if tokens is empty, that is an error
                    if tokens.count == 0 then (
                        print "Error: missing CSV header"
                    )
                    
                    -- get the point in time 
                    tick = tokens[1] as float

                    -- get the frame number
                    frame = tokens[2] as integer

                    with animate on (
                        -- set the proper time for this frame
                        at time frame (
    
                            -- now we can simply go through in order and tell each node/servo to update
                            for index=3 to tokens.count do (
                                -- the angle, or value, to set this node to
                                angle = tokens[index] as float
                                
                                -- get the node from the array and tell it to set itself. subtract 2 to account
                                -- for the time and frame items
                                if nodes[index-2] != undefined then (
                                    nodes[index-2].setAngle angle
                                )
                            )
                        )
                    )
                )
            )
        )
    )
    
    function import_from_umf fs =
    (
        -- TODO
    )
    
    function set_device =
    (
        local device = "Unknown"
        
        if getNodeByName "pleo" != undefined then (
            format "got pleo"
            device = "Pleo"
        )
        
        if device != "Unknown" then (
			-- load the proper definitions for the selected device
			-- local device = device_list.items[index]
			local deviceServos = device + "Servos.ms"
			local deviceSounds = device + "Sounds.ms"
			
			-- important bit here is that we define the servo structs
			fileIn deviceServos
			-- import bit here is that we define a soundTable array
			fileIn deviceSounds
		)
    )
    

    -- GUI  
    group "Import CSV Animation" (
        button import_button "Import" width:100
    )
    
    group "Export CSV Animation" (
        spinner framerate_text "Frame Rate:" range:[1,100,30] type:#integer fieldWidth:32 align:#left -- pos:[20,85]
        label format_label "Format:" across:2 align:#left -- pos:[20,115]
        dropdownlist export_list "" items:#("CSV", "UMF") width:50 align:#left -- pos:[73,110]
        button export_button "Export" width:100
    )
    
    rollout about_ugobe "About UGOBE Utilities"
    (
        button about_button "About" width:100

        on about_button pressed do
        (
            messageBox "Brought to you by the nice folks at UGOBE.\n© 2005-2007 UGOBE. All Rights Reserved." title:"About UGOBE Utilities"
        )
    )

    on import_button pressed do
    (
        -- make sure we have set up the servo array
        updateServos()

        file = getOpenFileName caption:"Open Animation From" types:"CSV(*.csv)|*.csv|UMF(*.umf)|*.umf|All|*.*|"
        if (file == undefined) then
            return false

        fs = openFile file mode:"rt"
        if fs == undefined then
            return false

        import_from_csv fs
        
        close fs
    )
    
    on export_button pressed do
    (
        -- make sure we have set up the servo array
        set_device()
        
        -- start with the proper extension
        if export_list.selected == "CSV" then
            name = "motion.csv"
        else
            name = "motion.umf"

        -- let the user choose a file
        file = getSaveFileName caption:"Save Animation As" filename:name
        if (file == undefined) then
            return false

        fs = createFile file
        if fs == undefined then
            return false
            
        -- set the frame rate before the export. should we save the previous value? (don't need to)
        frameRate = framerate_text.value as integer
        
        if export_list.selected == "CSV" then
            export_as_csv fs
        else
            export_as_umf fs
            
        close fs
    )
    
--  on close_button pressed do
--  (
--      closeUtility Ugobe
--  )

    on Ugobe open do
    (
        addRollout about_ugobe rolledUp:true
        
        set_device()
    )
    
    on Ugobe close do
    (
        removeRollout about_ugobe
    )
)


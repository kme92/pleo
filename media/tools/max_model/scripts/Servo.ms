--
-- this file defines the servo 'class'
-- functionality that relates to servos should be added here as struct function members

-- this is the servo 'class' with member variables and methods
struct Servo
(
    name, ref, description, motor, axis, amin, amax, last_angle,
    
    function onCreate =
    (
        ref = getNodeByName name
    ),
    
    function doUpdate =
    (
        ref = getNodeByName name
    ),
    
    function getAxis =
    (
        axis
    ),
    
    function getName =
    (
        name
    ),
    
    function getAngle =
    (
        angle = 0.0
        
        mc = getNodeByName "Main_Control"
        
        if mc != undefined then (
            ah = mc.attribute_holder
            
            try (
                lookup_name = name
                
                -- hack to handle the "TO" servo joint. better here than a whole
                -- new member
                if name == "TO" then
                    lookup_name = "TO_"
                    
                angle = getProperty ah lookup_name
                
                -- format "getAngle(%) = %\n" name angle

            ) catch (
                -- fail silently, it's okay, value will just default to 0.0
                
            )
            
            -- now clip angle to amin/amax
            -- Disable since they will clip downstream...
            -- if (name != "SD" || name != "TR") then (
            --  if (angle > amax) then angle = amax
            --  if (angle < amin) then angle = amin
            --)
        ) else (
            format "no main control found\n"
        )
        
        angle
    ),
    
    function setAngle angle =
    (
        -- format "setAngle(% %)\n" angle last_angle
        
        if ref == undefined then (
            -- format "setAngle called on undefined servo %\n" name
            return 0.0
        )
        
        if last_angle == undefined then (
            last_angle = 0.0
        ) else (
            if axis == "X" then in coordsys local rotate ref (EulerAngles -last_angle 0.0 0.0)
            if axis == "Y" then in coordsys local rotate ref (EulerAngles 0.0 -last_angle 0.0)
            if axis == "Z" then in coordsys local rotate ref (EulerAngles 0.0 0.0 -last_angle)
        )
        
        if angle < amin or angle > amax then (
            format "Angle % out of range [%,%] in %\n" angle amin amax ref
        ) 
        
        if ref != undefined then (
            if axis == "X" then in coordsys local rotate ref (EulerAngles angle 0.0 0.0)
            if axis == "Y" then in coordsys local rotate ref (EulerAngles 0.0 angle 0.0)
            if axis == "Z" then in coordsys local rotate ref (EulerAngles 0.0 0.0 angle)
        )
        
        last_angle = angle
    ),
    
    function getRange =
    (
        angle = getAngle()
        hi = amax + abs(amin)
        (angle * (255.0/hi)) as integer
    ),
    
    function inRig =
    (
        true -- ref != undefined
    ),
    
    dummy = onCreate()
)

-- some common functions, assuming the global servos array exists

function updateServos =
(
    createServos()
    
    for s in servos do (
        s.doUpdate()
    )
)

function getServoByName name =
(
    -- make sure they are up-to-date first
    -- okay, don't do this! this resets any state in the servo objects, resulting in bad behavior.
    -- updateServos()

    for s in servos do (
        if name == s.name then
            return s
    )
)

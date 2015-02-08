
include "Servo.ms"

function createServos =
(
    global sre = Servo name:"RE" description:"Right Elbow"     motor:"1A" axis:"Z"  amin:-90.0  amax:90.0
    global srs = Servo name:"RS" description:"Right Shoulder"  motor:"1B" axis:"Z"  amin:-30.0  amax:30.0
    global sle = Servo name:"LE" description:"Left Elbow"      motor:"2A" axis:"Z"  amin:-90.0  amax:90.0
    global sls = Servo name:"LS" description:"Left Shoulder"   motor:"2B" axis:"Z"  amin:-30.0  amax:30.0
    global snv = Servo name:"NV" description:"Neck Vertical"   motor:"3A" axis:"Z"  amin:-180.0 amax:180.0
    global snh = Servo name:"NH" description:"Neck Horizontal" motor:"3B" axis:"Y"  amin:-180.0 amax:180.0
    global shd = Servo name:"HD" description:"Head"            motor:"4A" axis:"Z"  amin:0.0    amax:360.0
    global srk = Servo name:"RK" description:"Right Knee"      motor:"5A" axis:"Z"  amin:-90.0  amax:90.0
    global srh = Servo name:"RH" description:"Right Hip"       motor:"5B" axis:"Z"  amin:-30.0  amax:30.0
    global slk = Servo name:"LK" description:"Left Knee"       motor:"6A" axis:"Z"  amin:-90.0  amax:90.0
    global slh = Servo name:"LH" description:"Left Hip"        motor:"6B" axis:"Z"  amin:-30.0  amax:30.0
    global stv = Servo name:"TV" description:"Tail Vertical"   motor:"7A" axis:"Z"  amin:-180.0 amax:180.0
    global sth = Servo name:"TH" description:"Tail Horizontal" motor:"7B" axis:"Y"  amin:-180.0 amax:180.0
    global sto = Servo name:"TO" description:"Torso"           motor:"8A" axis:"Z"  amin:-55.0  amax:55.0
    global ssd = Servo name:"SD" description:"Sound"           motor:"NA" axis:"Z"  amin:0.0    amax:0.0
    global str = Servo name:"TR" description:"Transition"      motor:"NA" axis:"Z"  amin:0.0    amax:0.0

    -- Set up the servo instance array
    global servos = #(sre, srs, sle, sls, snv, snh, shd, srk, srh, slk, slh, stv, sth, sto, ssd, str)
)

createServos()
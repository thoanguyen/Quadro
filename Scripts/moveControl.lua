-- new script file
-- new script file
function OnAfterSceneLoaded(self)
  self.controls = Input:CreateMap("InputMap")
  
  player = Game:GetEntity("player") -- remember to have an object with objectkey named player
  MoveSpeed = 20
  
  self.controls:MapTrigger("KeyLeft", "KEYBOARD", "CT_KB_A")
  self.controls:MapTrigger("KeyRight", "KEYBOARD", "CT_KB_D")
  self.controls:MapTrigger("KeyUp", "KEYBOARD", "CT_KB_W")
  self.controls:MapTrigger("KeyDown", "KEYBOARD", "CT_KB_S")
  
  --Create a virtual thumbstick then setup controls for it
  Input:CreateVirtualThumbStick()
  self.controls:MapTrigger("TouchLeft", "VirtualThumbStick", "CT_PAD_LEFT_THUMB_STICK_LEFT", {deadzone = 0.1})
  self.controls:MapTrigger("TouchRight", "VirtualThumbStick", "CT_PAD_LEFT_THUMB_STICK_RIGHT", {deadzone = 0.1})
  self.controls:MapTrigger("TouchUp", "VirtualThumbStick", "CT_PAD_LEFT_THUMB_STICK_UP", {deadzone = 0.1})
  self.controls:MapTrigger("TouchDown", "VirtualThumbStick", "CT_PAD_LEFT_THUMB_STICK_DOWN", {deadzone = 0.1})

end


function OnThink(self)
  -- Pull in keyboard controls
  local KeyGoLeft = self.controls:GetTrigger("KeyLeft")>0
  local KeyGoRight = self.controls:GetTrigger("KeyRight")>0
  local KeyGoUp = self.controls:GetTrigger("KeyUp")>0
  local KeyGoDown = self.controls:GetTrigger("KeyDown")>0
  
  --Get Touch Controls
  local TouchGoLeft = self.controls:GetTrigger("TouchLeft")>0
  local TouchGoRight = self.controls:GetTrigger("TouchRight")>0
  local TouchGoUp = self.controls:GetTrigger("TouchUp")>0
  local TouchGoDown = self.controls:GetTrigger("TouchDown")>0
  
  if KeyGoLeft or TouchGoLeft then
      player:IncPosition(0,MoveSpeed,0)
  end
  
  if KeyGoRight or TouchGoRight then
      player:IncPosition(0,(MoveSpeed*-1),0)
  end
  
  if KeyGoUp or TouchGoUp then
      player:IncPosition(MoveSpeed,0,0)
  end
  
  if KeyGoDown or TouchGoDown then
      player:IncPosition((MoveSpeed*-1),0,0)
  end
        
end
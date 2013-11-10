
function OnAfterSceneLoaded(self)
	Debug:Enable(true)
  
  --G.AddAtom = AddAtom
  G.AddEffects = AddEffects
  
  self.map = Input:CreateMap("InputMap")
  self.map:MapTrigger("X", "MOUSE", "CT_MOUSE_ABS_X")
  self.map:MapTrigger("Y", "MOUSE", "CT_MOUSE_ABS_Y")
  self.map:MapTrigger("Pick", "MOUSE", "CT_MOUSE_LEFT_BUTTON", {once = false})
  
  --Game:InstantiatePrefab(self:GetPosition(), "Prefabs\\Oxygen.prefab")
  
  --G.AddAtom(Vision.hkvVec3(10,20,0), "Models/Hydrogen.model", "H")
  --G.AddAtom(Vision.hkvVec3(20,30,0), "Models/Oxygen.model", "O")
  --G.AddAtom(Vision.hkvVec3(-10,0,0), "Models/Hydrogen.model", "H")
  
  --Game:InstantiatePrefab(self:GetPosition(), "Prefabs\Hydrogen.prefab")
end

function AddEffects(self,correct)

  if correct then
    local effect = Game:CreateEffect(self:GetPosition(), "Particles\\effect05.xml") 
  else
    local effect2 = Game:CreateEffect(self:GetPosition(), "Particles\\effect02.xml")
  end

end

--[[
function AddAtom(pos, model, name)

  bob =  Game:CreateEntity(pos, "VisBaseEntity_cl", model, name)
  bob:AddComponentOfType("vHavokRigidBody", "hRigid")
  bob:SetScaling(1.5)
  bob:SetTraceAccuracy(Vision.TRACE_POLYGON)
  
  if name == "O" then
    bob:AddComponentOfType("VScriptComponent", "Scripts/O.lua")
  end

  return bob
  
end
]]--

function OnThink(self)

	local X = self.map:GetTrigger("X")
	local Y = self.map:GetTrigger("Y")
  
  Debug.Draw:Line2D(X,Y,X+10,Y+5, Vision.V_RGBA_GREEN)
  Debug.Draw:Line2D(X,Y,X+5,Y+10, Vision.V_RGBA_GREEN)
  Debug.Draw:Line2D(X+10,Y+5,X+5,Y+10, Vision.V_RGBA_GREEN)
  
  if self.map:GetTrigger("Pick") > 0 then
      
    self.point = Screen:PickPoint(X, Y, 1000)
    
    if self.picked == nil then
    
      local picked = Screen:PickEntity(X, Y, 1000, true)
      
      if picked ~= nil then
      
        local par = picked
        
        while par:GetParent() ~= nil do
          par = par:GetParent()
        end
      
        self.start = self.point
        
        self.picked = par
        
      end
      
    end
    
  else
  
    self.picked = nil
    
    self.point = nil
    
  end
  
  if self.picked ~= nil and self.point ~= nil then
  
    while  self.picked:GetParent() ~= nil do
       self.picked =  self.picked:GetParent()
    end
    
    -- only allow movement along XY plane
    local diff = self.start.z - self.point.z
    local cam = Game:GetCamera()
    local camDir = self.point - cam:GetPosition()
    camDir = camDir * (1 / camDir.z)
    self.point = self.point + camDir * diff
    
    -- apply linear velocity to block
    local move = Vision.hkvVec3(self.point.x - self.start.x, self.point.y - self.start.y, 0)
    
    if (move:getLength() > 200) then
      move:setLength(200)
    end
    
    self.picked:GetComponentOfType("vHavokRigidBody"):SetLinearVelocity(move * 2)
  end
  
  
end

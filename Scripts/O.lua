local count = 0

disp = 35

-- info fields: HitPoint, HitNormal, Force, RelativeVelocity,
--              ColliderType, ColliderObject (maybe nil)
function OnCollision(self, info)
	if info.ColliderObject:GetKey() == "H" then
  
    info.ColliderObject:RemoveComponentOfType("vHavokRigidBody")
    
    local offset = Vision.hkvVec3(0, 0, 0)
    
    self:SetDirection(offset)
    
    if count == 0 then
      offset = Vision.hkvVec3(-disp,0,0)
    elseif count == 1 then
      offset = Vision.hkvVec3(0, -disp, 0)
    elseif count == 2 then
      offset = Vision.hkvVec3(disp, 0, 0)
    elseif count == 3 then
      offset = Vision.hkvVec3(0, disp, 0)
    end
    count = count + 1
    
    G.AddEffects(self,false)
    
    info.ColliderObject:SetPosition(self:GetPosition() + offset)
    info.ColliderObject:AttachToParent(self)
  end
end

-- new script file
local s = 0;

function OnObjectEnter(self, object)
	if object == Game:GetEntity("hydrogen1") then
   s = s + 50
   Debug:PrintLine("Score: " .. s)
  end
  if object == Game:GetEntity("hydrogen2") then
   s = s + 50
   Debug:PrintLine("Score: " .. s)
   else 
   s = s - 75
   Debug:PrintLine("Score: " .. s)
  end
end

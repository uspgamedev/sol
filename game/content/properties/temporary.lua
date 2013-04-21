
module ('content.properties', package.seeall)

require 'base.property'

temporary = base.property:new {
  expiretime = 5.0, -- in seconds
  timer = 0.0       -- counts time, shouldn't be changed
}

function temporary.triggers:update (dt)
  self.temporary.timer = self.temporary.timer + dt
  if self.temporary.timer >= self.temporary.expiretime then
    self:destroy()
  end
end

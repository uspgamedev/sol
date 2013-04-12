
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.geom.vector'

moveable = base.property:new {
  requires = { 'visible' }
}

moveable.__init = {
  controller = {
    up    = 100*lux.geom.vector:new {0,-1},
    down  = 100*lux.geom.vector:new {0,1},
    left  = 100*lux.geom.vector:new {-1,0},
    right = 100*lux.geom.vector:new {1,0}
  }
}

function moveable.triggers:update (dt)
  local speed = lux.geom.vector:new{}
  if type(self.moveable.controller) == 'table' then
    for key,vec in pairs(self.moveable.controller) do
      if love.keyboard.isDown(key) then
        speed = speed + vec
      end
    end
  elseif type(self.moveable.controller) == 'function' then
    speed = self.moveable.controller(self)
  end
  self.visible.pos = self.visible.pos + dt*speed
end

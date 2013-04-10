
module ('content.triggers', package.seeall)

require 'base.trigger'

mouse_pressedleft = base.trigger:new {}

function mouse_pressedleft:check (x, y)
  return self.visible and self.visible:inside(lux.geom.point:new {x,y})
end

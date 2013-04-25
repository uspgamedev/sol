
module ('content.triggers', package.seeall)

require 'base.trigger'

mouse_pressedleft = base.trigger:new {}

function mouse_pressedleft:check (x, y)
  if self.visible then
    return self.visible:inside(lux.geom.point:new {x,y})
  else
    return true
  end
end

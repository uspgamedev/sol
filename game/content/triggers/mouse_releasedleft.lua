
module ('content.triggers', package.seeall)

require 'base.trigger'

mouse_releasedleft = base.trigger:new {}

function mouse_releasedleft:check (x, y)
  return (self.visible and self.visible:inside(lux.geom.point:new {x,y})) or self.alwaystrigger
end

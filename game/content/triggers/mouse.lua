
module ('content.triggers.mouse', package.seeall)

require 'base.trigger'

pressedleft = base.trigger:new {}

function pressedleft:check (x, y)
  return self:inside(lux.geom.point:new {x,y})
end

releasedleft = base.trigger:new {}

function releasedleft:check (x, y)
  return self:inside(lux.geom.point:new {x,y})
end

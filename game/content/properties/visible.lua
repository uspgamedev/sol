
module ('content.properties', package.seeall)

require 'base.property'
require 'base.primitive'
require 'lux.geom.vector'
require 'lux.functional'
require 'content.triggers.draw'

visible = base.property:new {
  pos = lux.geom.point:new {0,0},
  size = lux.geom.vector:new {64,64},
}

function visible.triggers:draw (graphics)
  for _,drawable in ipairs(self.visible.draw) do
    drawable:draw(self, graphics)
  end
end

visible.__init = {
  draw = {
    base.primitive.rectangle:new{ color = {150, 150, 255, 100}, mode = 'fill' },
    base.primitive.rectangle:new{ color = {150, 150, 150, 255}, mode = 'line' },
    base.primitive.text:new {}
  }
}

function visible:left ()
  return self.pos.x - self.size.x/2
end

function visible:right ()
  return self.pos.x + self.size.x/2
end

function visible:top ()
  return self.pos.y - self.size.y/2
end

function visible:bottom ()
  return self.pos.y + self.size.y/2
end

function visible:inside (p) 
  if p.x < self:left() then return false end
  if p.y < self:top() then return false end
  if p.x > self:right() then return false end
  if p.y > self:bottom() then return false end
  return true
end


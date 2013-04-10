
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.geom.vector'
require 'content.triggers.draw'

visible = base.property:new {}

function visible:visit (element)
  element.pos   = element.pos or lux.geom.point:new {0,0}
  element.size  = element.size or lux.geom.vector:new {64,64}
  for name,operation in pairs(self.operations) do
    element[name] = operation
  end
  content.triggers.draw:register(element, self.draw)
end

function visible:draw (graphics)
  graphics.setColor(150, 150, 255, 100)
  graphics.rectangle('fill', 0, 0, self.size.x, self.size.y)
  graphics.setColor(150, 150, 150, 255)
  graphics.rectangle('line', 0, 0, self.size.x, self.size.y)
  graphics.setColor(200, 200, 100, 255)
  graphics.printf(self.name, 0, 0, self.size.x, 'center')
end

function visible.operations:left ()
  return self.pos.x
end

function visible.operations:right ()
  return self.pos.x + self.size.x
end

function visible.operations:top ()
  return self.pos.y
end

function visible.operations:bottom ()
  return self.pos.y + self.size.y
end

function visible.operations:inside (p)
  if p.x < self:left() then return false end
  if p.y < self:top() then return false end
  if p.x > self:right() then return false end
  if p.y > self:bottom() then return false end
  return true
end


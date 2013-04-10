
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.geom.vector'
require 'content.triggers.draw'

visible = base.property:new {
  pos = lux.geom.point:new {0,0},
  size = lux.geom.vector:new {64,64},
}

function visible.triggers:draw (graphics)
  self.visible:draw(graphics, self.name)
end

function visible:draw (graphics, name)
  graphics.setColor(150, 150, 255, 100)
  graphics.rectangle('fill', 0, 0, self.size.x, self.size.y)
  graphics.setColor(150, 150, 150, 255)
  graphics.rectangle('line', 0, 0, self.size.x, self.size.y)
  graphics.setColor(200, 200, 100, 255)
  graphics.printf(name, 0, 0, self.size.x, 'center')
end

function visible:left ()
  return self.pos.x
end

function visible:right ()
  return self.pos.x + self.size.x
end

function visible:top ()
  return self.pos.y
end

function visible:bottom ()
  return self.pos.y + self.size.y
end

function visible:inside (p)
  if p.x < self:left() then return false end
  if p.y < self:top() then return false end
  if p.x > self:right() then return false end
  if p.y > self:bottom() then return false end
  return true
end


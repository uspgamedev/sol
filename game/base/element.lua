
module ('base', package.seeall)

require 'lux.object'
require 'lux.geom.vector'
require 'base.trigger'

element = lux.object.new {
  name  = 'Unnamed Element',
  pos   = lux.geom.point:new {0,0},
  size  = lux.geom.vector:new {64,64}
}

function element:__init()
  self.triggers = trigger.make_table(self)
end

function element:left ()
  return self.pos.x
end

function element:right ()
  return self.pos.x + self.size.x
end

function element:top ()
  return self.pos.y
end

function element:bottom ()
  return self.pos.y + self.size.y
end

function element:inside (p)
  if p.x < self:left() then return false end
  if p.y < self:top() then return false end
  if p.x > self:right() then return false end
  if p.y > self:bottom() then return false end
  return true
end

function element:draw (graphics)
  graphics.setColor(150, 150, 255, 100)
  graphics.rectangle('fill', 0, 0, self.size.x, self.size.y)
  graphics.setColor(150, 150, 150, 255)
  graphics.rectangle('line', 0, 0, self.size.x, self.size.y)
  graphics.setColor(200, 200, 100, 255)
  graphics.printf(self.name, 0, 0, self.size.x, 'center')
end

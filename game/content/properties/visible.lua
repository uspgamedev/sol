
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
  local draw = self.visible.draw
  if type(draw) == 'string' then
    draw = assert(loadstring(draw), "Element '"..self.name.."': Couldn't load draw function.")
  elseif type(draw) == 'table' and base.primitive[draw.__type] then
    draw = lux.functional.bindleft(draw.draw, draw)
  end
  draw(self, graphics)
end

function visible:draw (graphics)
  -- This is the default drawing function for visible elements
  base.primitive.rectangle:new{ color = {150, 150, 255, 100}, mode = 'fill' }:draw(self, graphics)
  base.primitive.rectangle:new{ color = {150, 150, 150, 255}, mode = 'line' }:draw(self, graphics)
  graphics.setColor(200, 200, 100, 255)
  graphics.printf(
    self.name,
    -self.visible.size.x/2,
    -self.visible.size.y/2,
    self.visible.size.x,
    'center'
  )
end

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


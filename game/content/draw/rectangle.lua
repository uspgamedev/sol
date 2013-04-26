
module ('content.draw', package.seeall)

require 'base.drawable'

rectangle = base.drawable:new {
  mode    = 'fill',
  width   = 32,
  height  = 32
}

function rectangle:getWidth ()
  return self.width
end

function rectangle:getHeight ()
  return self.height
end

function rectangle:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.rectangle(
    self.mode,
    -self.width/2,
    -self.height/2,
    self.width,
    self.height
  )
end

function rectangle:left ()
  return -self.width/2
end

function rectangle:right ()
  return self.width/2
end

function rectangle:top ()
  return -self.height/2
end

function rectangle:bottom ()
  return self.height/2
end

function rectangle:inside (p) 
  if p.x < self:left() then return false end
  if p.y < self:top() then return false end
  if p.x > self:right() then return false end
  if p.y > self:bottom() then return false end
  return true
end


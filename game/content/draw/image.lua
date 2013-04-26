
module ('content.draw', package.seeall)

require 'base.drawable'

image = base.drawable:new {
  path = 'jigsaw-box.png'
}

local cash = {}

function image:__init ()
  cash[self.path] =
    cash[self.path] or love.graphics.newImage('resource/images/'..self.path)
  self.data = cash[self.path]
end

function image:getWidth ()
  return self.data:getWidth()
end

function image:getHeight ()
  return self.data:getHeight()
end

function image:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.draw(self.data, 0, 0, 0, 1, 1, self.data:getWidth()/2, self.data:getHeight()/2)
end

function image:inside (p)
  local width, height = self.data:getWidth(), self.data:getHeight()
  if p.x < -width/2 then return false end
  if p.y < -height/2 then return false end
  if p.x > width/2 then return false end
  if p.y > height/2 then return false end
  return true
end

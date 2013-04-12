
module ('base.primitive', package.seeall)

require 'lux.object'
require 'lux.geom.vector'

--- Drawable
drawable = lux.object.new {
  color   = nil
}

drawable.__init = {
  color = {255, 255, 255, 255}
}

--- Rectangle
rectangle = drawable:new {
  mode = 'fill'
}

function rectangle:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.rectangle(
    self.mode,
    -element.visible.size.x/2,
    -element.visible.size.y/2,
    element.visible.size:unpack()
  )
end

--- Circle
circle = drawable:new {
  mode = 'fill'
}

function circle:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.circle(
    self.mode,
    0, 0,
    math.min(element.visible.size.x, element.visible.size.y)
  )
end

--- Image
image = drawable:new {
  path = 'jigsaw-box.png'
}

local cash = {}

function image:__init ()
  cash[self.path] = cash[self.path] or love.graphics.newImage('resource/images/'..self.path)
  self.data = cash[self.path]
end

function image:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.draw(
    self.data,
    0,
    0,
    0,
    element.visible.size.x/self.data:getWidth(),
    element.visible.size.y/self.data:getHeight(),
    self.data:getWidth()/2,
    self.data:getHeight()/2
  )
end

--- Some mystic code
for name,primitive in pairs(_M) do
  if type(primitive) == 'table' and primitive.new then
    primitive.__type = name
  end
end

--- Copy LUX's geometric primitives.
vector  = lux.geom.vector
point   = lux.geom.point

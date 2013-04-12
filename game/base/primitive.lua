
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

--- Some mystic code
for name,primitive in pairs(_M) do
  if type(primitive) == 'table' and primitive.new then
    primitive.__type = name
  end
end

--- Copy LUX's geometric primitives.
vector  = lux.geom.vector
point   = lux.geom.point


module ('base.primitive', package.seeall)

require 'lux.object'
require 'lux.geom.vector'

drawable = lux.object.new {
  color   = nil
}

drawable.__init = {
  color = {255, 255, 255, 255}
}

rectangle = lux.object.new {
  mode    = 'fill',
  width   = 64,
  height  = 64
}

function rectangle:draw (graphics)
  graphics.setColor(self.color)
  graphics.draw(self.mode, -self.width/2, -self.height/2, self.width, self.height)
end

for name,primitive in pairs(_M) do
  if type(primitive) == 'table' and primitive.new then
    primitive.__type = name
  end
end

vector  = lux.geom.vector
point   = lux.geom.point


module ('game', package.seeall)

require 'lux.object'
require 'lux.geom.vec'

element = lux.object.new {
  name  = 'Unnamed Element',
  pos   = lux.geom.point:new {0,0},
  size  = lux.geom.vec:new {64,64}
}

function element:draw (graphics)
  graphics.rectangle('line', self.pos.x, self.pos.y, self.size.x, self.size.y)
  graphics.printf(self.name, 0, 0, self.size.x, 'center')
end

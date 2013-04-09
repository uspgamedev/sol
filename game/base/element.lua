
module ('base', package.seeall)

require 'lux.object'
require 'lux.geom.vector'

element = lux.object.new {
  name  = 'Unnamed Element',
  pos   = lux.geom.point:new {0,0},
  size  = lux.geom.vector:new {64,64}
}

function element:draw (graphics)
  graphics.setColor(150, 150, 255, 100)
  graphics.rectangle('fill', self.pos.x, self.pos.y, self.size.x, self.size.y)
  graphics.setColor(150, 150, 150, 255)
  graphics.rectangle('line', self.pos.x, self.pos.y, self.size.x, self.size.y)
  graphics.setColor(200, 200, 100, 255)
  graphics.printf(self.name, 0, 0, self.size.x, 'center')
end

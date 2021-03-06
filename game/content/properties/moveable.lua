
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.geom.vector'

moveable = base.property:new {
  requires = { 'visible' }
}

moveable.__init = {
  speed = lux.geom.vector:new {}
}

function moveable.triggers:update (dt)
  self.visible.position = self.visible.position + self.moveable.speed*dt
end

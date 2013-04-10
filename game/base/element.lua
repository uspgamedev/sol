
module ('base', package.seeall)

require 'lux.object'
require 'lux.geom.vector'
require 'content.triggers.draw'

element = lux.object.new {
  name  = 'Unnamed Element'
}

function element:add_property (property)
  property:visit(self)
end

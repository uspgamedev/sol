
module ('base', package.seeall)

require 'lux.object'
require 'lux.geom.vector'
require 'content.triggers.draw'

element = lux.object.new {
  name  = 'Unnamed Element'
}

function element:add_property (property)
  for _,required_property in pairs(property.requires) do
    self:add_property(required_property)
  end
  property:visit(self)
end

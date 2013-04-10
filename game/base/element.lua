
module ('base', package.seeall)

require 'lux.object'
require 'lux.functional'
require 'content.properties'

element = lux.object.new {
  name  = 'Unnamed Element'
}

function element:add_property (property_name, data)
  -- Chain call
  if not data then
    return lux.functional.bindleft(element.add_property, self, property_name)
  end
  -- Cannot add the same property again
  if self[property_name] then return end
  -- Get the property object
  local property = content.properties[property_name]
  -- Add the property's required properties
  for _,required_name in pairs(property.requires) do
    self:add_property(required_name, {})
  end
  -- Clone the property into the element
  self[property_name] = property:new{}
  for key,value in pairs(data) do
    self[property_name][key] = value
  end
  property:visit(self)
  return self
end

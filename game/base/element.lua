
module ('base.element', package.seeall)

require 'lux.object'
require 'lux.functional'
require 'content.properties'
require 'content.triggers'

local elements      = {}
local element       = lux.object.new {
  name  = 'Unnamed Element'
}

getmetatable(_M).__call = function (_, name)
  if elements[name] then
    return elements[name]
  end
  local new_element = element:new { name = name }
  elements[name] = new_element
  return new_element
end

function exists (name)
  return elements[name] ~= nil
end

function element:add_property (property_name, data)
  -- Chain call
  if not data then
    return lux.functional.bindleft(element.add_property, self, property_name)
  end
  -- Cannot add the same property again
  if self[property_name] then return self end
  -- Get the property object
  local property = content.properties[property_name]
  -- Add the property's required properties
  for _,required_name in pairs(property.requires) do
    self:add_property(required_name, {})
  end
  -- Clone the property into the element
  local added_property = property:new(data)
  self[property_name] = added_property
  added_property:start(self, property)
  return self
end

function element:property (property_name, data)
  -- Chain call
  if not data then
    return lux.functional.bindleft(element.property, self, property_name)
  end
  -- If does not have the property, then add it
  if not self[property_name] then
    return self:add_property(property_name, data)
  end
  local changed_property = self[property_name]
  -- Apply changes
  for k,v in pairs(data) do
    if k == math.floor(k) and k >= 1 and k <= #data then
      table.insert(changed_property, v)
    else
      changes[k] = v
    end
  end
  changed_property:start(self, property)
  return self
end

function element:remove_property (property_name)
  -- Look for the property
  local to_be_removed = self[property_name]
  -- Cannot remove a property that isn't there
  if not to_be_removed then return end
  to_be_removed:finish(self)
  content.triggers.update:unregister(to_be_removed, to_be_removed.update)
  self[property_name] = nil
end

function element:destroy ()
  for property_name,_ in pairs(self) do
    if property_name ~= 'name' then
      self:remove_property(property_name)
    end
  end
  elements[self.name] = nil
end

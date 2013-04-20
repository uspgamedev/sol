module("content.recipes.button",package.seeall)

require 'base.element'
require 'base.message'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'
require 'content.properties'

function make ( elements, name, data)
  if elements[name] then return elements[name] end
  if not data then
    return lux.functional.bindleft(content.recipes.button.make, elements, name)
  end
  
  local element = base.element:new{ name = name }

  element:add_property('clickable', data)

  elements[element.name] = element
  return element
end

function trigger( elements, name )
  return elements[name].clickable.totrigger
end

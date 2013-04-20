module("content.recipes.button",package.seeall)

require 'base.element'
require 'base.message'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'
require 'content.properties'

function make (name, data)
  
  local element = base.element:new{ name = name }

  element:add_property('clickable', data)

  return element
end

function trigger( elements, name )
  return elements[name].clickable.totrigger
end

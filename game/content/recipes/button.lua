module("content.recipes.button",package.seeall)

require 'base.element'
require 'base.message'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'
require 'content.properties'

function make (name, data)
  
  local element = base.element(name)
  
  element:add_property('clickable', data)

  return element
end

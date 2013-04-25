module('content.recipes.creator',package.seeall)

require 'lux.object'
require 'base.element'
require 'base.property'

function make(name, data)

  local creator = base.element(name)
  data.makerecipe = require('content.recipes.' .. data.recipe).make

  creator:add_property('creates', data)
  
  return creator

end
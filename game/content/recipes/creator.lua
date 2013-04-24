module('content.recipes.creator',package.seeall)

require 'lux.object'
require 'base.element'
require 'base.property'

function make(name, data)

  local creator = base.element(name)
  local makerecipe = require('content.recipes.' .. data.recipe).make
  if data.number then
    data.makerecipe = function (...)
      for i=1,data.number do 
        makerecipe(...) 
      end
    end
  else
    data.makerecipe = makerecipe
  end

  creator:add_property('creates', data)
  
  return creator

end
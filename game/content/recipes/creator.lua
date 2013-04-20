module('content.recipes.creator',package.seeall)

require 'lux.object'
require 'base.element'
require 'base.property'

function make(elements, name, data)
  if not data then
    return lux.functional.bindleft(content.recipes.creator.make, elements, name)
  end

  local createfunc = require('content.recipes.' .. data.recipe).make
  local creator = base.element:new{}
  local property = base.property:new{}
  
  for _,link in ipairs(data.args) do
    getfenv(link.action).property  = data.args
  end

  if not data.args.name then data.args.name = name .. '_' .. data.recipe end
  
  creator.name = name
  creator.alwaystrigger = true
  
  local triggertype = type(data.trigger)

  data.args.nextID = 0
  if triggertype=='string' then 
    property.triggers[data.trigger] = function(self)
      for _,link in ipairs(data.args) do link.action() end
      createfunc(elements, data.args.name..'(#'..data.args.nextID..')', data.args)
      data.args.nextID = data.args.nextID+1
    end
  elseif triggertype=='table' then
    table.insert(data.trigger,function()
      for _,link in ipairs(data.args) do link.action() end
      createfunc(elements, data.args.name..'(#'..data.args.nextID..')', data.args)
      data.args.nextID = data.args.nextID+1
    end)
  end
   
  -- FIXME
  creator.checktriggers = property
  property:add_triggers(creator)
  elements[creator.name] = creator
  return creator
end
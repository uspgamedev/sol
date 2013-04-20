module('content.recipes.creator',package.seeall)

require 'lux.object'
require 'base.element'
require 'base.property'

function make(name, data)

  local createfunc = require('content.recipes.' .. data.recipe).make
  local creator = base.element:new{}
  local property = base.property:new{}
  

  if not data.args.name then data.args.name = name .. '_' .. data.recipe end
  
  creator.name = name
  
  local triggertype = type(data.trigger)

  local function f ()
    for _,link in ipairs(data.args) do
      getfenv(link.action).property  = data.args
      link.action()
    end 
    createfunc(data.args.name..'(#'..data.args.nextID..')', data.args)
    data.args.nextID = data.args.nextID+1
  end

  data.args.nextID = 0
  if triggertype=='string' then 
    property.triggers[data.trigger] = f
  elseif triggertype=='table' then
    table.insert(data.trigger,f)
  end
   
  -- FIXME
  creator.checktriggers = property:new{}
  creator.checktriggers:start(creator)
  return creator
end
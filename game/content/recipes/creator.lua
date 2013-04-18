module('content.recipes.creator',package.seeall)

require 'base.element'
require 'base.property'
require 'base.message'

function new(elements, name, data)
  if not data then
    return lux.functional.bindleft(content.recipes.creator.new, elements, name)
  end

  local createfunc = require('content.recipes.' .. data.recipe).create
  local creator = base.element:new{}
  local property = base.property:new{}
  
  for _,link in ipairs(data.args) do
    getfenv(link.action).property  = data.args
  end

  if not data.args.name then data.args.name = name .. '_' .. data.recipe end
  
  creator.name = name
  creator.alwaystrigger = true
  
  local triggertype = type(data.trigger)

  if triggertype=='string' then 
    property.triggers[data.trigger] = function(self,...)
     for _,link in ipairs(data.args) do link.action() end
      createfunc(elements,data.args,...) 
    end
  elseif triggertype=='function' then
   -- data.trigger(function(self,...)
   --  for _,link in ipairs(data.args) do link.action() end
   --   createfunc(elements,data.args,...) 
   -- end)
  end
   
  creator.checktriggers = property
  property:visit(creator)
  elements[creator.name] = creator
  return creator
end
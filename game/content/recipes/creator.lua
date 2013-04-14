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
  local property =base.property:new{}
  
  for _,link in ipairs(data.args) do
    getfenv(link.action).property  = data.args
  end

  creator.name = name
  creator.alwaystrigger = true
  property.triggers[data.trigger] = function(self,...)
     for _,link in ipairs(data.args) do link.action() end
     createfunc(elements,data.args,...) 
   end
  creator.checktriggers = property
  property:visit(creator)
  elements[creator.name] = creator
  return creator
end

--build.creator 'FireShooter' {
-- builder = 'bullet',
-- trigger = 'mouse_pressedleft',
-- args = {
--  parts = { circle{ color={255,0,0,255} } },
--  power = 10, --not used yet
--  apply { fromcontext='homing', to='from', with='@pos' }
-- }
--}
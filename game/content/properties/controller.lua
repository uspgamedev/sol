
module ('content.properties', package.seeall)

require 'base.property'
require 'base.message'

controller = base.property:new {
  target = 'all'  
}

function controller.triggers:update ()
  self.controller.update(self)
end

function controller:send (what, value)
  base.message.send(self.target, what, value)
end

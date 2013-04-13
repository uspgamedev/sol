
module ('content.properties', package.seeall)

require 'base.property'
require 'base.message'

controller = base.property:new {
  sendto = 'all'  
}

function controller.triggers:update ()
  self.controller.update(self)
end

function controller:send (what, value)
  base.message.send(self.sendto, what, value)
end

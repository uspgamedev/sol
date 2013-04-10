
module ('content.elements', package.seeall)

require 'base.element'
require 'content.triggers.mouse'
require 'content.triggers.update'

grabbable = base.element:new {}

function grabbable:__init ()
  content.triggers.mouse.pressedleft:register(self, self.grab)
  content.triggers.mouse.releasedleft:register(self, self.letgo)
end

function grabbable:grab ()
  content.triggers.update:register(
    self,
    function (self)
      self.pos = lux.geom.point:new {love.mouse.getPosition()} - self.size*.5
    end
  )
end

function grabbable:letgo ()
  content.triggers.update:unregister(self)
end
